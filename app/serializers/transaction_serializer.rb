class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :amount, :status
  # has_one :account
end
