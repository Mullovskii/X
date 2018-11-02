class OrderSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :shop_id, :address_id, :status, :kind, :amount_in_cents, :shipping_amount_in_cents, :total_amount_in_cents, :currency_id, :vat_in_cents, :blogger_reward_in_cents, :surf_reward_in_cents, :discount_in_cents, :confirmed_at, :cancelled_at
  has_one :user
end
