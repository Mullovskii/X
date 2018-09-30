class Product < ApplicationRecord
	belongs_to :shop
	belongs_to :feed, optional: true
	belongs_to :brand, optional: true
    has_many :orders, as: :ordered

	has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'
    has_many :hashtags, through: :tags, :source => :tagger,
    :source_type => 'Hashtag'

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
    has_one :delivery

    after_create :add_country
    # after_update :add_point_prices

    default_scope { order("created_at DESC") }

    def delivery
        self.feed.delivery if self.feed
    end

    def active_campaigns
        self.feed.campaigns.where(status: "ongoing") if self.feed
    end

    def add_country
        self.update(country_id: self.feed.country_id) if self.feed        
    end


    # def add_point_prices
    #     if self.saved_change_to_gift_mode?
    #         if self.shop.reward && self.shop.reward.product_reward == true
    #             if self.shop.reward.currency_id == self.feed.currency_id 
    #                 self.point_price = (self.price / self.shop.reward.point_to_lcy*100).round / 100.0
    #             else
    #                 self.point_price = (self.price / self.feed.currency.usd_rate / self.shop.reward.point_to_usd*100).round / 100.0 
    #             end 
    #         end
    #         self.save
    #     end
    # end
 
    
end
