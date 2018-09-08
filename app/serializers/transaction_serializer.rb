class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :purchased_id, :purchased_type, :amount, :status
  has_one :account
end
