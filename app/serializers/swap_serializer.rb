class SwapSerializer < ActiveModel::Serializer
  attributes :id, :points, :bonuses, :status, :card_number
  has_one :user
  has_one :shop
end
