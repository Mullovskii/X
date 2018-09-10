class CitySerializer < ActiveModel::Serializer
  attributes :id, :country_id, :name
end
