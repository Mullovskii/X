class Product < ApplicationRecord
	belongs_to :shop
	belongs_to :feed, optional: true
	belongs_to :brand, optional: true

	has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'

    has_many :links, as: :linked
	has_many :picks, through: :links, :source => :linking,
    :source_type => 'Pick'
    has_many :campaigns, through: :links, :source => :linking,
    :source_type => 'Campaign'
    belongs_to :campaign, optional: true
    has_many :clicks
    has_many :gifts
    has_many :product_coupons
    has_many :coupons, through: :product_coupons

    has_many :active_campaigns

    def active_campaigns
        self.feed.campaigns.where(status: "fresh")
    end
 
    
end
