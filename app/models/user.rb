class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	         :recoverable, :rememberable, :trackable, :validatable

	enum role: [ :swimming_pool_baby, :swimming_coach, :versed_surfer, :god ]
	enum sex: [:female, :male]
	# validates :username, uniqueness: true
	# validates :phone, uniqueness: true

	has_many :links, as: :author, dependent: :destroy
	has_many :picks, as: :author, dependent: :destroy
	has_many :shops, as: :owner
	has_one :showroom, as: :owner
	has_many :winner_clicks, class_name: "Click", foreign_key: "winner_id"
	has_many :my_clicks, class_name: "Click", foreign_key: "clicker_id"

	has_many :user_campaigns
	has_many :campaigns, through: :user_campaigns
	has_many :launched_campaigns, as: :author, class_name: "Campaign", foreign_key: "author_id"

	after_create :generate_showroom

	has_many :active_relationships, as: :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, as: :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

	  
	has_many :following, through: :active_relationships, :source => :follower,
	    :source_type => 'User'
	has_many :followers, through: :passive_relationships, :source => :followed,
	    :source_type => 'User'

    has_many :employments
    has_many :jobs, through: :employments, :source => :shop


    has_many :tags, as: :tagged, dependent: :destroy
    has_many :hashtags, through: :tags, :source => :tagger,
    :source_type => 'Hashtag'
    
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'



	def generate_showroom
		Showroom.create(owner_id: self.id, owner_type: self.class.to_s)
	end

	def employed_in(shop)
		if self.employments.where(shop_id: shop.id, status: :approved).take
			true
		else
			false
		end
	end

	def true_picker?(user_campaign)
		if user_campaign.link.linking.author == self
			if user_campaign.campaign.link_referral == true && user_campaign.link.kind == "external_link" 
				if user_campaign.link.external_link.match?(user_campaign.campaign.link_1) || user_campaign.link.external_link.match?(user_campaign.campaign.link_2) || user_campaign.link.external_link.match?(user_campaign.campaign.link_3) || user_campaign.link.external_link.match?(user_campaign.campaign.link_4) || user_campaign.link.external_link.match?(user_campaign.campaign.link_5)
					true
				end
			elsif user_campaign.campaign.product_tagging == true && user_campaign.link.kind == "product_pick" 
				if user_campaign.campaign.campaign_products == "all_country_products" && user_campaign.link.linked.shop == user_campaign.campaign.shop || user_campaign.campaign.campaign_products == "selected_feeds" && user_campaign.campaign.feeds.where(id: user_campaign.link.linked.feed.id).take || user_campaign.campaign.label_1 == user_campaign.link.linked.campaign_label && user_campaign.link.linked.shop == user_campaign.campaign.shop
					true
				end
			end
		end
	end

end
