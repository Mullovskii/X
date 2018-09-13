class Swap < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :account
  has_one :operation, class_name: "Transaction", foreign_key: "swap_id", dependent: :destroy
  enum status: [:pending, :fulfilled, :cancelled]

  after_update :generate_transaction


  def generate_transaction
  	if self.saved_change_to_status? && self.status == "fulfilled"
        Transaction.create(account_id: self.account_id, swap_id: self.id, amount: self.amount)
    elsif self.saved_change_to_status? && self.status == "cancelled"
    	self.operation.destroy if self.operation
    end
  end

end
