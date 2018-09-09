class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :purchased_id, :purchased_type, :amount, :status, :order_id
  # has_one :account
end
