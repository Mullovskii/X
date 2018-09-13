class CouponSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :country_id, :kind, :discount_mode, :discount, :discount_products, :additional_info, :coupon_use, :instruction, :background, :point_price, :number_of_coupons, :number, :status, :buyer_id, :purchased_at, :utilized_at, :currency_id
  has_one :shop
  has_many :products
end
