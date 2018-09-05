class Campaign < ApplicationRecord

	enum status: [:fresh, :submitted, :declined, :ongoing, :stopped, :cancelled, :finished]
	enum kind: [:referral, :purchase]
	enum campaign_products: [:all_country_products, :selected_feeds, :labeled]


	belongs_to :shop
	belongs_to :author, polymorphic: true, optional: true

	# has_many :links, as: :linking, dependent: :destroy
	has_many :links, as: :linked, dependent: :destroy
	has_many :products, through: :links, :source => :linked,
    :source_type => 'Product'
    has_many :feed_campaigns
    has_many :feeds, through: :feed_campaigns

    has_many :user_campaigns
    has_many :users, through: :user_campaigns
    has_many :gifts

    after_create :activate_products

    def activate_products
    	if self.campaign_products == "all_country_products"
    		self.shop.feeds.where(country_id: self.country_id).each do |feed|
    			FeedCampaigns.create(feed_id: feed.id, campaign_id: self.id)
    		end
    	end
    end


end

