class CurrencySerializer < ActiveModel::Serializer
  attributes :id, :name, :country_id, :symbolic_name
end
