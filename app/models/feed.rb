class Feed < ApplicationRecord
	belongs_to :shop
	has_many :products, dependent: :destroy
	has_many :gifts, dependent: :destroy
	has_many :feed_campaigns
	has_many :campaigns, through: :feed_campaigns
	enum kind: [:product_feed, :gift_feed]

end

