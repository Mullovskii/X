class CouponSerializer < ActiveModel::Serializer
  attributes :id, :kind, :discount_mode, :discount, :discount_products, :additional_info, :coupon_use, :instruction, :background, :point_price, :secret_key, :generated_amount, :generated_number, :parent_id, :status, :buyer_id, :purchased_at, :utilized_at
  has_one :shop
end
