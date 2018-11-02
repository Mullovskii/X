class CountryShopSerializer < ActiveModel::Serializer
  attributes :id, :mode
  has_one :shop
  has_one :country
end
