class Feed < ApplicationRecord
	belongs_to :shop
	has_many :products
	has_many :feed_campaigns
	has_many :campaigns, through: :feed_campaigns
end
