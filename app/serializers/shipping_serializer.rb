class ShippingSerializer < ActiveModel::Serializer
  attributes :id, :provider, :tracking_number, :note, :status, :kind, :delivered_at
  belongs_to :shop
  belongs_to :order
  belongs_to :dispute
end
