class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :vat
end
