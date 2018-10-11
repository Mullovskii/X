class Delivery < ApplicationRecord
  belongs_to :shop
  belongs_to :product, optional: true 
  belongs_to :country, optional: true
  has_many :tariffs

  enum mode: [:default, :specific]
  validates :product_id, uniqueness: { scope: [:shop_id, :country_id] }
end
