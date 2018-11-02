class TariffSerializer < ActiveModel::Serializer
  attributes :id, :name, :kind, :mode, :product_price_from, :product_price_to, :weight_from, :weight_to, :price_in_cents
  has_one :delivery
end
