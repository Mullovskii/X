class CurrencySerializer < ActiveModel::Serializer
  attributes :id, :name, :usd_rate, :ruble_rate
end