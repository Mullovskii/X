class Invoice < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :shop, optional: true
  belongs_to :user, optional: true
  belongs_to :campaign, optional: true
  has_one :operation, class_name: "Transaction", foreign_key: "invoice_id", dependent: :destroy

  enum status: [:pending, :cleared_and_paid, :unauthorized, :cancelled_and_refunded]
  enum payment_method: [:bank_transfer, :card]
  enum kind: [:topup, :withdrawal]

  # after_create :check_payment
  after_create :add_account
  after_update :change_balance

  def valid_amount
    if self.kind == "withdrawal"
      self.currency_id = self.account.currency_id
      if self.user_id == self.account.user_id && self.amount >= 10 && self.account.balance >= self.amount 
        true
      else
        false
      end
    end
  end


  def add_account
    if self.kind == "topup"
      self.account_id = self.campaign.account.id
      self.currency_id = self.campaign.currency_id
      self.vat = self.campaign.country.vat
      self.save
    elsif self.kind == "withdrawal"
      self.currency_id = self.account.currency_id
      self.save
    end
  end

  def change_balance
  	if self.saved_change_to_status? 
  		if self.status == "cleared_and_paid"
        if self.kind == "topup"
          Transaction.create(credit_account_id: self.account.id, amount: self.amount, currency_id: self.currency_id , kind: "topup", invoice_id: self.id)  
          self.campaign.status = "ongoing"
          self.campaign.save
        elsif self.kind == "withdrawal" && self.user_id == self.account.user_id && self.amount >= 10 && self.account.balance >= self.amount 
          Transaction.create(debit_account_id: self.account.id, amount: self.amount, currency_id: self.currency_id , kind: "withdrawal", invoice_id: self.id)  
        else
          self.status = "unauthorized"
          self.save
        end
  		elsif self.status == "cancelled_and_refunded"
  			self.operation.destroy if self.operation 
  		end  	
  	end
  end

end
