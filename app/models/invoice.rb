class Invoice < ApplicationRecord
  belongs_to :account
  belongs_to :shop
  belongs_to :campaign
  has_one :operation, class_name: "Transaction", foreign_key: "invoice_id"

  enum status: [:pending, :cleared_and_paid, :cancelled_and_refunded]
  enum payment_type: [:bank_transfer, :card]

  # after_create :check_payment
  after_update :topup_balance

  # def check_payment
 	
  # end

  def topup_balance
  	if self.saved_change_to_status? 
  		if self.status == "cleared_and_paid"
  			Transaction.create(credit_account_id: self.account.id, amount: self.amount, kind: "topup", invoice_id: self.id)	 
  		elsif self.status == "cancelled_and_refunded"
  			self.operation.destroy if self.operation 
  		end  	
  	end
  end

end
