class Account < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  has_many :transactions
end
