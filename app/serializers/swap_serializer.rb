class SwapSerializer < ActiveModel::Serializer
  attributes :id, :amount, :bonuses, :status, :card_number, :account_id
  has_one :user
  has_one :shop
end
