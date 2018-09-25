class Country < ApplicationRecord
	enum status: [:surfed, :unsurfed]
	has_many :country_shops
	has_many :shops, through: :country_shops
	has_many :cities
	has_one :currency
end
