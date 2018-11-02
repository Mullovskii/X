class AddressSerializer < ActiveModel::Serializer
  attributes :id, :country_id, :city_id, :street_id, :owner_id, :owner_type, :building, :apartment, :postcode, :kind
  has_one :country
  has_one :city
  has_one :street
end
