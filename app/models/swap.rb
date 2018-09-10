class Swap < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :account

  after_create :generate_transaction

  def generate_transaction
  	Transaction.create(account_id: self.account_id, swap_id: self.id, amount: self.amount)
  end
end
