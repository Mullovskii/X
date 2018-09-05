class Coupon < ApplicationRecord
  belongs_to :shop
  enum kind: [:discount_coupon, :product_coupon]
  enum discount_mode: [:percentage, :money]
  enum discount_products: [:all, :selected]
  enum coupon_use: [:online, :offline]
  enum status: [:active, :purchased, :utilized, :cancelled]



end
