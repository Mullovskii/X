class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :purchased, polymorphic: true
  belongs_to :order, optional: true
  belongs_to :swap, optional: true
  enum kind: [:points, :real]

  after_create :change_balance
  before_destroy :return_points


  def change_balance
  	if self.kind == "points"
	  	self.account.balance -= self.amount
	  	self.account.save
	end
  end

  def return_points
  	if self.kind == "points"
	  	self.account.balance += self.amount
	  	self.account.save
	end
  end

end