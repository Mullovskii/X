class Order < ApplicationRecord
  enum status: [:edited, :user_confirmed, :cleared, :fulfilled, :delivered, :unauthorized, :user_cancelled, :shop_cancelled, :user_refunded, :shop_refunded, :surf_refunded]
  enum kind: [:product, :sample_product]
  belongs_to :user
  belongs_to :product
  belongs_to :shop, optional: true
  belongs_to :currency, optional: true
  has_many :transactions, dependent: :destroy
  has_one :operation, class_name: "Transaction", foreign_key: "order_id"
  after_create :add_info
  after_update :payment_authorization, :change_virtual_balances
  

  def add_info
    self.shop = self.product.shop
    self.amount = self.product.price
    # self.currency = self.product.currency
    if self.product.deliveries.where(country_id: self.user.country_id).take
      self.shipping_amount = self.product.deliveries.where(country_id: self.user.country_id).take.price  
    elsif self.shop.deliveries.where(mode: "default", country_id: self.user.country_id).take
      self.shipping_amount = self.shop.deliveries.where(mode: "default", country_id: self.user.country_id).take.price
    end
    self.total_amount = self.amount + self.shipping_amount
    self.surf_reward = self.total_amount * 0.15
    self.save
  end

  def checked_for_quantity?
    self.product.quantity >= self.quantity
  end

  def moderated?
    self.saved_change_to_status? && self.status == "delivered"
  end

  def payment_authorization
    if self.saved_change_to_status? && self.status == "user_confirmed"
      #ходим в платежную систему за авторизацией
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
      self.update(status: 'cleared')
    else
      self.update(status: 'unauthorized')
    end   
  end

  def change_virtual_balances
    if self.saved_change_to_status? && self.status == "cleared"
      credit_shop_balance
      credit_surf_balance
      reward_blogger
    end
  end

  def credit_shop_balance
    account = self.shop.account
    Transaction.create(credit_account: account, order_id: self.id, product_id: self.product.id, amount: self.total_amount - self.surf_reward, currency_id: self.currency_id) 
  end

  def credit_surf_balance
    account = Account.where(kind: "surf").first_or_create
    Transaction.create(credit_account: account, order_id: self.id, product_id: self.product.id, amount: self.surf_reward, currency_id: self.currency_id) 
  end

  def reward_blogger
    if self.product.clicks.first
      account = self.product.clicks.first.user.accounts.where(currency_id: self.currency_id).first_or_create
      Transaction.create(credit_account: account, order_id: self.id, product_id: self.product.id, amount: self.surf_reward / 3, currency_id: self.currency_id) 
    end
  end



  # def authorize_order
  # 	if self.shop.integration_type == "manual"
  # 		self.update(status: "authorized", confirmed_at: Time.now)
  # 		unless self.kind == "sample"
  # 			Transaction.create(account_id: self.user.accounts.where(shop_id: self.shop.id).take.id, order_id: self.id, purchased_id: self.ordered_id, purchased_type: self.ordered_type, amount: self.amount)	
  # 		end
  # 	end
  # end


end
