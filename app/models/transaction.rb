class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :order
  enum kind: [:points, :real]

  after_create :change_balance

  def change_balance
  	if self.kind == "points"
	  	self.account.balance -= self.amount
	  	self.account.save
	end
  end

end
