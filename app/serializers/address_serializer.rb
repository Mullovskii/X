class AddressSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :owner_type, :additional, :postcode
  has_one :country
  has_one :city
  has_one :street
end
