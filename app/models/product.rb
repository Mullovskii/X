class Product < ApplicationRecord
    enum status: [:unverified, :approved]
    
    default_scope { order("created_at DESC") }

	belongs_to :shop
    belongs_to :currency, optional: true
	belongs_to :feed, optional: true
	belongs_to :brand, optional: true
    has_many :orders, as: :ordered
    belongs_to :main_category, class_name: 'Category', foreign_key: 'main_category_id', optional: true
    has_many :deliveries
	has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'
    has_many :hashtags, through: :tags, :source => :tagger,
    :source_type => 'Hashtag'
    has_many :links, as: :linked
	has_many :picks, through: :links, :source => :linking,
    :source_type => 'Pick'
    has_many :clicks, through: :links
    has_many :product_showrooms
    has_many :wishes
    has_many :likes, as: :liked
    
    after_create :add_category, :add_brand_tags_to_shop, :price_to_cents
    # before_create :price_to_cents

    include PgSearch
    multisearchable :against => :title
    paginates_per 10

    

    # has_many :campaigns, through: :links, :source => :linking,
    # :source_type => 'Campaign'
    # belongs_to :campaign, optional: true
    # has_many :gifts
    # has_many :product_coupons
    # has_many :coupons, through: :product_coupons
    # has_many :active_campaigns
    # after_create :add_country
    # after_update :add_point_prices

    def price_to_cents
        unless self.currency == Currency.where(name: ["KRW", 'JPY', 'HUF', 'ISK']).take
            self.price_in_cents = self.price_in_cents.to_f*100
            self.sale_price_in_cents = self.sale_price_in_cents.to_f*100
        end
        self.save
    end

    def add_category
        self.main_category_id = Category.where(name: self.product_type).first_or_create.id
    end   

    def product_deliveries
        self.deliveries + self.shop.deliveries.where(mode: "default").where.not(country_id: self.deliveries.map{|d| d.country_id} ) 
    end

    def add_brand_tags_to_shop
        self.shop.tags.create(tagger: self.brand)
    end

    def price_to_usd
        Money.new(self.price, self.currency.name).exchange_to("USD")
    end

    def destock(order_quantity)
        self.quantity -= order_quantity
        self.save
        puts "4hahahah"
    end

    def return_stock(order_quantity)
        self.quantity += order_quantity
        self.save
    end
   

    # def active_campaigns
    #     self.feed.campaigns.where(status: "ongoing") if self.feed
    # end

    # def add_country
    #     self.update(country_id: self.feed.country_id) if self.feed        
    # end


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
