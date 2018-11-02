class Order < ApplicationRecord
  enum status: [:edited, :no_shipping, :user_confirmed, :unauthorized, :cleared, :fulfilled, :delivered, :user_cancelled, :shop_cancelled, :disputed, :user_refunded, :refund_refused, :settled_to_shop]
  enum kind: [:product, :sample_product]
  belongs_to :user
  belongs_to :product
  belongs_to :shop, optional: true
  belongs_to :address, optional: true
  belongs_to :currency, optional: true
  has_many :transactions, dependent: :destroy
  has_one :shipping, dependent: :destroy
  has_one :dispute, dependent: :destroy
  after_create :add_info, unless: :sample_product?
  after_update :update_address, :update_order_quantity, :payment_authorization, :change_virtual_balances,  :refund_order, unless: :sample_product?
  after_update :cancel_order
  default_scope { order("created_at DESC") }
  # SURF_FEE = 0.15
  # YANDEX_PROCESSOR_FEE = 0.035
  # SURF_GROSS_FEE = SURF_FEE-YANDEX_PROCESSOR_FEE

  def sample_product?
    self.kind == "sample_product"
  end
  

  def add_info
    self.shop = self.product.shop
    self.product_price_in_cents = self.product.price_in_cents
    self.product_currency_id = self.product.currency_id
    if self.product_currency_id == Currency.where(name: "RUB").take.id || self.product_currency_id == Currency.where(name: "USD").take.id
      self.amount_in_cents = self.product_price_in_cents
      self.currency_id = self.product_currency_id
    else
      self.currency = Currency.where(name: "USD").take
      self.amount_in_cents = (self.product.price_to_usd*100).round(2)
    end
    if product_delivery = self.product.deliveries.where(country_id: self.user.country_id).take || product_delivery = self.shop.deliveries.where(mode: "default", country_id: self.user.country_id).take
      if product_delivery.currency == self.currency
        self.shipping_price_in_cents = product_delivery.price_in_cents
        self.shipping_amount_in_cents = self.shipping_price_in_cents
      elsif self.currency.name == "RUB" && product_delivery.currency.name != "RUB"
        self.shipping_price_in_cents = (product_delivery.price_to_rub).round(2)
        self.shipping_amount_in_cents = self.shipping_price_in_cents
      else
        self.shipping_price_in_cents = (product_delivery.price_to_usd).round(2)
        self.shipping_amount_in_cents = self.shipping_price_in_cents
      end  
    end
    self.total_amount_in_cents = self.amount_in_cents + self.shipping_amount_in_cents
    self.surf_reward_in_cents = (self.total_amount_in_cents * SURF_GROSS_FEE).round(2)
    self.save
    # self.usd_price = self.product.currency.to_usd_price(amount)
    # self.amount = self.currency.to_local_price(self.usd_price)
    # self.address = self.user.address
    # self.currency = self.product.currency
  end

  def moderated?
    # self.saved_change_to_status? && self.status == "delivered"
  end

  def in_stock?
    self.product.quantity >= self.quantity
  end

  def cancellation_expired?
    if self.paid_at.nil?
      false
    else
      ((Time.now - self.paid_at)/1.hour).round >= 7 && self.saved_change_to_status && self.status == "user_cancelled" || ((Time.now - self.paid_at)/1.hour).round >= 7 && self.saved_change_to_status && self.status == "shop_cancelled"
    end
  end

  def refund_invalid?
    self.status == "user_refunded" && self.shipping.nil?
  end

  def refund_expired?
    if self.paid_at.nil?
      false
    else
      ((Time.now - self.paid_at)/1.day).round >= 14 && self.saved_change_to_status && self.status == "user_refunded"
    end
  end

  def payment_authorization
    if self.saved_change_to_status? && self.status == "user_confirmed" && self.in_stock?
      #ходим в платежную систему за холдированием
      # если успех, то
      if true
        payment_clearing
      else
        self.update(status: 'unauthorized')
      end     
    end
  end

  def payment_clearing
    #ходим в платежную систему за клирингом
    # если успех, то
    if true
      self.update(status: 'cleared', psp_payment_id: "X", paid_at: DateTime.now)
    else
      self.update(status: 'unauthorized')
    end   
  end

  def change_virtual_balances
    if self.saved_change_to_status? && self.status == "cleared"
      destock_product
      credit_shop_balance
      credit_surf_balance
      reward_blogger
    end
  end

  def destock_product
    self.product.destock(self.quantity)
  end

  def credit_shop_balance
    account = self.shop.accounts.where(currency_id: self.currency_id).first_or_create
    Transaction.create(credit_account_id: account.id, order_id: self.id, product_id: self.product_id, amount_in_cents: (self.total_amount_in_cents - self.surf_reward_in_cents), currency_id: self.currency_id)     
  end

  def credit_surf_balance
    account = Account.where(kind: "surf", currency_id: self.currency_id).first_or_create
    Transaction.create(credit_account_id: account.id, order_id: self.id, product_id: self.product.id, amount_in_cents: self.surf_reward_in_cents, currency_id: self.currency_id, kind: "surf_reward") 
  end

  def reward_blogger
    if click = self.product.clicks.first
      blogger_account = click.blogger.accounts.where(currency_id: self.currency_id).first_or_create
      surf_account = Account.where(kind: "surf").first_or_create
      reward = Transaction.create(credit_account_id: blogger_account.id, debit_account_id: surf_account.id, order_id: self.id, product_id: self.product.id, amount_in_cents: self.amount_in_cents*BLOGGER_REWARD_FEE, currency_id: self.currency_id, kind: "blogger_reward")  
      change_surf_reward(reward.amount_in_cents)
    end
  end

  def change_surf_reward(blogger_reward_amount)
    self.blogger_reward_in_cents = blogger_reward_amount
    self.surf_reward_in_cents -= self.blogger_reward_in_cents
    self.save
  end


  def update_address
    if self.saved_change_to_address_id && self.address.country != self.user.country
      if product_delivery = self.product.deliveries.where(country_id: self.address.country_id).take || product_delivery = self.shop.deliveries.where(mode: "default", country_id: self.address.country_id).take
        if product_delivery.currency == self.currency
          self.shipping_price_in_cents = product_delivery.price_in_cents
          self.shipping_amount_in_cents = self.shipping_price_in_cents
        elsif self.currency.name == "RUB" && product_delivery.currency.name != "RUB"
          self.shipping_price_in_cents = product_delivery.price_to_rub.round(2)
          self.shipping_amount_in_cents = self.shipping_price_in_cents 
        else
          self.shipping_price_in_cents = product_delivery.price_to_usd.round(2)
          self.shipping_amount_in_cents = self.shipping_price_in_cents 
        end  
      else
        self.status = "no_shipping"
      end
      self.total_amount_in_cents = self.amount_in_cents + self.shipping_amount_in_cents
      self.surf_reward_in_cents = (self.total_amount_in_cents * SURF_GROSS_FEE).round(2)
      self.save
    end
  end

  def update_order_quantity
    if self.saved_change_to_quantity
      self.amount_in_cents = self.product_price_in_cents*self.quantity
      self.shipping_amount_in_cents = self.shipping_price_in_cents*self.quantity
      self.total_amount_in_cents = self.amount_in_cents + self.shipping_amount_in_cents
      self.surf_reward_in_cents = (self.total_amount_in_cents * SURF_GROSS_FEE).round(2)
      self.save
    end
  end

  def cancel_order
    if self.saved_change_to_status? && self.status == "user_cancelled" ||  self.saved_change_to_status? && self.status == "shop_cancelled"# before fullfilment start / before / clearing / before settlement to YM
      # calculate return for user munus shipping, processing costs + refund fine (if any)
      cancel_transactions
      return_stock
    end
  end

  def refund_order
    if self.saved_change_to_status? && self.status == "user_refunded" # after fullfilment start
      # - shipping - processing costs - refund fine (if any)
      # refund_sum = (self.total_amount_in_cents - self.shipping_amount_in_cents - YANDEX_REFUND_FEE - (self.total_amount_in_cents*YANDEX_PROCESSOR_FEE))
      # - processing costs - refund fine (if any)
      refund_sum = (self.total_amount_in_cents - self.shipping_amount_in_cents - YANDEX_REFUND_FEE - (self.total_amount_in_cents*YANDEX_PROCESSOR_FEE))
      refund_currency = self.currency.name
      payment_id = self.psp_payment_id
      generate_psp_refund(refund_sum, refund_currency, payment_id)
    end
  end

  def generate_psp_refund(refund_sum, refund_currency, payment_id)
    #code for POST https://payment.yandex.net/api/v3/refunds
    if true
      cancel_transactions
      return_stock
      # shop_shipping_refund
    end
  end

  def cancel_transactions
    self.transactions.each do |t|
      t.update(status: "cancelled")
    end
  end

  def return_stock
    self.product.return_stock(self.quantity)
  end

  # def shop_shipping_refund
  #   account = self.shop.accounts.where(currency_id: self.currency_id).first
  #   transaction = Transaction.create(credit_account_id: account.id, order_id: self.id, product_id: self.product_id, amount_in_cents: self.shipping_amount_in_cents, currency_id: self.currency_id, kind: "shipping_refund") 
  # end
  

  # def authorize_order
  # 	if self.shop.integration_type == "manual"
  # 		self.update(status: "authorized", confirmed_at: Time.now)
  # 		unless self.kind == "sample"
  # 			Transaction.create(account_id: self.user.accounts.where(shop_id: self.shop.id).take.id, order_id: self.id, purchased_id: self.ordered_id, purchased_type: self.ordered_type, amount: self.amount)	
  # 		end
  # 	end
  # end


end
