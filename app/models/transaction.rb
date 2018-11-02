class Transaction < ApplicationRecord
  belongs_to :credit_account, foreign_key: "credit_account_id", class_name: "Account", optional: true #пополнение
  belongs_to :debit_account, foreign_key: "debit_account_id", class_name: "Account", optional: true #списание
  # belongs_to :purchased, polymorphic: true, optional: true
  belongs_to :order, optional: true
  # belongs_to :swap, optional: true
  belongs_to :invoice, optional: true
  # belongs_to :click, optional: true
  belongs_to :currency, optional: true
  enum kind: [:shop_sale, :surf_reward, :blogger_reward, :withdrawal, :shipping_refund]
  enum status: [:cleared, :cancelled]


  after_create :change_balance
  after_update :cancel_revert_balance
  before_destroy :revert_balance


  def change_balance
  	if self.kind == "shop_sale" || self.kind == "surf_reward" || self.kind == "shipping_refund"
      self.credit_account.balance_in_cents += self.amount_in_cents
      self.credit_account.save
    elsif self.kind == "blogger_reward" 
      self.debit_account.balance_in_cents -= self.amount_in_cents
      self.debit_account.save
      self.credit_account.balance_in_cents += self.amount_in_cents
      self.credit_account.save
    elsif self.kind == "withdrawal" && self.amount_in_cents >= 1000 && self.debit_account.balance_in_cents >= self.amount_in_cents
      self.debit_account.balance_in_cents -= self.amount_in_cents
      self.debit_account.save
    else
        self.status = "cancelled"
        self.save
	  end
  end

  def revert_balance
    if self.kind == "shop_sale" || self.kind == "surf_reward"
      self.credit_account.balance_in_cents -= self.amount_in_cents
      self.credit_account.save
    elsif self.kind == "blogger_reward" 
      self.debit_account.balance_in_cents += self.amount_in_cents
      self.debit_account.save
      self.credit_account.balance_in_cents -= self.amount_in_cents
      self.credit_account.save
    elsif self.kind == "withdrawal" && self.amount_in_cents >= 1000 && self.debit_account.balance_in_cents >= self.amount_in_cents
      self.debit_account.balance_in_cents += self.amount_in_cents
      self.debit_account.save
    else
        self.status = "cancelled"
        self.save
    end
  end

  def cancel_revert_balance
    if self.saved_change_to_status? && self.status == "cancelled" # after fullfilment start
      revert_balance
    end
  end

  # def return_points
  # 	if self.kind == "points" && self.debit_account
  #     self.debit_account.balance += self.amount
  #     self.debit_account.save
  #   elsif self.kind == "reward" && self.debit_account 
	 #  	self.debit_account.balance += self.amount
	 #  	self.debit_account.save
  #     if self.credit_account
  #       self.credit_account.balance -= self.amount
  #       self.credit_account.save 
  #     end
  #   elsif self.kind == "topup" && self.credit_account 
  #     self.credit_account.balance -= self.amount
  #     self.credit_account.save
  #   elsif self.kind == "withdrawal" && self.debit_account 
  #     self.debit_account.balance += self.amount
  #     self.debit_account.save
	 #  end
  # end

end
