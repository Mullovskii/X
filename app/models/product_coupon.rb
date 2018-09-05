class ProductCoupon < ApplicationRecord
  belongs_to :product
  belongs_to :coupon
end
