class OrderSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :shop_id, :address_id, :status, :kind, :amount, :shipping_amount, :total_amount, :vat, :blogger_reward, :surf_reward, :discount, :confirmed_at, :cancelled_at
  has_one :user
  has_one :operation
end
