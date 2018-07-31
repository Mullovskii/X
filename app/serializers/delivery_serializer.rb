class DeliverySerializer < ActiveModel::Serializer
  attributes :id, :mode, :weekends_delivery, :holidays_delivery, :pickup
  has_one :shop
  has_one :country
end
