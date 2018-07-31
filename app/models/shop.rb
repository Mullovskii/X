class Shop < ApplicationRecord
	belongs_to :owner, polymorphic: true
	has_many :feeds
	has_many :products
	has_many :campaigns
	enum status: [:brand_owned, :user_owned, :marketplace]
	enum kyc: [:fresh, :unverified, :in_progress, :verified]
end
