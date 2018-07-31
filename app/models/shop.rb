class Shop < ApplicationRecord
	belongs_to :owner, polymorphic: true
	has_many :feeds
	has_many :products
	has_many :campaigns
	has_many :country_shops
	has_many :countries, through: :country_shops
	has_many :deliveries
	has_many :clicks, through: :products
	has_many :employments
	has_many :employees, through: :employments, :source => :user

	enum status: [:brand_owned, :user_owned, :marketplace]
	enum kyc: [:fresh, :unverified, :in_progress, :verified]

end
