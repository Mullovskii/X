class Transaction < ApplicationRecord
  belongs_to :credit_account, class_name: "Account", optional: true
  belongs_to :debit_account, class_name: "Account", optional: true
  # belongs_to :purchased, polymorphic: true, optional: true
  # belongs_to :order, optional: true
  # belongs_to :swap, optional: true
  belongs_to :invoice, optional: true
  belongs_to :click, optional: true
  belongs_to :currency
  enum kind: [:points, :real, :topup, :reward, :withdrawal]
  enum status: [:pending, :cancelled]


  after_create :change_balance
  before_destroy :return_points


  def change_balance
  	if self.kind == "points" 
      self.debit_account.balance -= self.amount
      self.debit_account.save
    elsif self.kind == "reward"
      if self.debit_account.balance >= self.amount
        self.debit_account.balance -= self.amount
        self.debit_account.save
        self.credit_account.balance += self.amount
        self.credit_account.save
      else
        self.debit_account.campaign.status = "low_funds"
        self.debit_account.campaign.save
        self.status = "cancelled"
        self.save
      end
    elsif self.kind == "topup"
      self.credit_account.balance += self.amount
      self.credit_account.save
    elsif self.kind == "withdrawal" && self.amount >= 10 && self.debit_account.balance >= self.amount
      self.debit_account.balance -= self.amount
      self.debit_account.save
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
