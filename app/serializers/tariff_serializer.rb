class TariffSerializer < ActiveModel::Serializer
  attributes :id, :mode, :price_from, :price_to, :weight_from, :weight_to, :days, :price, :currency_id
  has_one :delivery
end
