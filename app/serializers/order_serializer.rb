class OrderSerializer < ActiveModel::Serializer
  attributes :id, :ordered_id, :ordered_type, :shop_id, :user_id, :status, :kind, :amount, :confirmed_at, :cancelled_at  
  has_one :user
end
