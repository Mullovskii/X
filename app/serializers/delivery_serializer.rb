class DeliverySerializer < ActiveModel::Serializer
  attributes :name, :id, :mode, :weekends_delivery, :holidays_delivery, :pickup, :days_from, :days_to
  has_one :shop
  has_one :country
end
