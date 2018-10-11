class DeliverySerializer < ActiveModel::Serializer
  attributes :name, :id, :product_id, :mode, :weekends_delivery, :holidays_delivery, :pickup, :days_from, :days_to, :price, :currency_id
  has_one :shop
  has_one :country
end
