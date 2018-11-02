class ProductCouponSerializer < ActiveModel::Serializer
  attributes :id
  has_one :product
  has_one :coupon
end
