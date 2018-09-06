class OrderSerializer < ActiveModel::Serializer
  attributes :id, :ordered_id, :ordered_type, :status, :kind, :value
  has_one :user
end
