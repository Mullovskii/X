class Order < ApplicationRecord
  belongs_to :user
  has_one :transaction
  enum status: [:success, :pending, :fulfilled]
end
