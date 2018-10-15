class Transaction < ApplicationRecord
  belongs_to :credit_account, class_name: "Account", optional: true #пополнение
  belongs_to :debit_account, class_name: "Account", optional: true #списание
  # belongs_to :purchased, polymorphic: true, optional: true
  belongs_to :order, optional: true
  # belongs_to :swap, optional: true
  belongs_to :invoice, optional: true
  belongs_to :click, optional: true
  belongs_to :currency
  enum kind: [:shop_sale, :surf_reward, :blogger_reward, :withdrawal]
  enum status: [:cleared, :cancelled]


  after_create :change_balance
  before_destroy :return_points


  def change_balance
  	if self.kind == "shop_sale" || self.kind == "surf_reward"
      self.credit_account.balance += self.amount
      self.save 
    elsif self.kind == "blogger_reward" 
      self.debit_account.balance -= self.amount
      self.debit_account.save
      self.credit_account.balance += self.amount
      self.save
    elsif self.kind == "withdrawal" && self.amount >= 10 && self.debit_account.balance >= self.amount
      self.debit_account.balance -= self.amount
      self.save
    else
        self.status = "cancelled"
        self.save
	  end
  end

  def return_points
  	if self.kind == "points" && self.debit_account
      self.debit_account.balance += self.amount
      self.debit_account.save
    elsif self.kind == "reward" && self.debit_account 
	  	self.debit_account.balance += self.amount
	  	self.debit_account.save
      if self.credit_account
        self.credit_account.balance -= self.amount
        self.credit_account.save 
      end
    elsif self.kind == "topup" && self.credit_account 
      self.credit_account.balance -= self.amount
      self.credit_account.save
    elsif self.kind == "withdrawal" && self.debit_account 
      self.debit_account.balance += self.amount
      self.debit_account.save
	  end
  end

end
