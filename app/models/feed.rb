class Feed < ApplicationRecord
	belongs_to :shop
	belongs_to :country
	has_many :products, dependent: :destroy
	has_many :gifts, dependent: :destroy
	has_many :feed_campaigns
	has_many :campaigns, through: :feed_campaigns
	enum mode: [:file, :mannual]
	enum format: [:xlsx, :csv, :txt]
	enum kind: [:product_feed, :gift_feed]

end

