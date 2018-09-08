class AccountSerializer < ActiveModel::Serializer
  attributes :id, :balance
  has_one :user
  has_one :shop
end
