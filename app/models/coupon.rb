class Coupon < ApplicationRecord
  belongs_to :shop
  belongs_to :country
  belongs_to :currency, optional: true
  has_many :product_coupons
  has_many :products, through: :product_coupons
  enum kind: [:discount_coupon, :product_coupon]
  enum discount_mode: [:percentage, :money]
  enum discount_products: [:all_products, :selected]
  enum coupon_use: [:online, :offline]
  enum status: [:active, :purchased, :utilized, :cancelled]


  def gift_mode
    true
  end
end
