class CountryShop < ApplicationRecord
  belongs_to :shop
  belongs_to :country
end
