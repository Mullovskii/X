class Campaign < ApplicationRecord

	enum status: [:low_funds, :ongoing, :halted]
	enum kind: [:referral, :purchase]
	enum campaign_products: [:all_country_products, :selected_feeds, :labeled]

    has_one :account
	belongs_to :shop
    belongs_to :currency
	belongs_to :author, polymorphic: true, optional: true

	# has_many :links, as: :linking, dependent: :destroy
	has_many :links, as: :linked, dependent: :destroy
	# has_many :products, through: :links, :source => :linked,
 #    :source_type => 'Product'
    has_many :feed_campaigns
    has_many :feeds, through: :feed_campaigns
    has_many :products, through: :feeds

    has_many :user_campaigns, dependent: :destroy
    has_many :users, through: :user_campaigns
    has_many :gifts
    belongs_to :country
    has_many :invoices

    after_create :activate_products, :generate_account

    def activate_products
    	if self.campaign_products == "all_country_products"
    		self.shop.feeds.where(country_id: self.country_id).each do |feed|
    			FeedCampaign.create(feed_id: feed.id, campaign_id: self.id)
    		end
    	end
    end

    def generate_account
        Account.create(shop_id: self.shop_id, campaign_id: self.id, currency_id: self.currency_id)
    end

    def ads_products
        
    end


end

