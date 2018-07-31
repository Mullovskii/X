class Delivery < ApplicationRecord
  belongs_to :shop
  belongs_to :country
  has_many :tariffs
end
