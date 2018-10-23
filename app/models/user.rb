class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	         :recoverable, :rememberable, :trackable, :validatable

	enum role: [ :swimming_pool_baby, :swimming_coach, :versed_surfer, :god ]
	enum sex: [:female, :male]
	validates :country_id, presence: true
	# validates :username, uniqueness: true
	# validates :phone, uniqueness: true
	belongs_to :country
	belongs_to :city, optional: true
	has_many :links, as: :author, dependent: :destroy
	has_many :picks, as: :author, dependent: :destroy
	has_many :shops, as: :owner
	has_one :showroom, as: :owner
	has_many :clicks
	has_many :addresses, as: :owner
	has_many :notifications, as: :notified, dependent: :destroy
	has_many :likes, as: :liker
	has_many :comments, as: :author
	has_many :wishes

	has_many :user_campaigns
	has_many :campaigns, through: :user_campaigns
	has_many :launched_campaigns, as: :author, class_name: "Campaign", foreign_key: "author_id"



	has_many :active_relationships, as: :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, as: :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :notifications, as: :notified
	  
	has_many :following, through: :active_relationships, :source => :followed,
	    :source_type => 'User'
	has_many :followers, through: :passive_relationships, :source => :follower,
	    :source_type => 'User'

    has_many :employments
    has_many :jobs, through: :employments, :source => :shop


    has_many :tags, as: :tagged, dependent: :destroy
    has_many :hashtags, through: :tags, :source => :tagger,
    :source_type => 'Hashtag'

	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'

    has_many :accounts, dependent: :destroy
    has_many :transactions, through: :accounts
    has_many :orders
    has_many :authorized_orders
    has_many :swaps
    has_many :coupons, through: :transactions, source: :purchased, :source_type => 'Coupon'
    has_many :products, through: :transactions, source: :purchased, :source_type => 'Coupon'
    has_many :gifts, through: :transactions, source: :purchased, :source_type => 'Coupon'
    belongs_to :country, optional: true
    has_many :invoices
    
    after_create :generate_showroom, :generate_account
    after_update :change_account

    default_scope { order("mana DESC") }


    include PgSearch
  	multisearchable :against => [:username, :full_name]

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

	def change_account
		if self.saved_change_to_country_id?
			generate_account
  		end
	end

	def generate_account
		account = Account.where(user_id: self.id, currency_id: self.country.currency.id).first_or_create
		account.main = true
		account.save
	end

	def main_account
		self.accounts.where(main: true).take
	end

	def main_address
		self.addresses.first
	end

	def true_picker?(user_campaign)
		if user_campaign.link.linking.author == self
			if user_campaign.campaign.link_referral == true && user_campaign.link.kind == "external_link" 
				if user_campaign.link.external_link.match?(user_campaign.campaign.link_1) || user_campaign.link.external_link.match?(user_campaign.campaign.link_2) || user_campaign.link.external_link.match?(user_campaign.campaign.link_3) || user_campaign.link.external_link.match?(user_campaign.campaign.link_4) || user_campaign.link.external_link.match?(user_campaign.campaign.link_5)
					true
				end
			elsif user_campaign.campaign.product_tagging == true && user_campaign.link.kind == "product_pick" 
				if user_campaign.campaign.campaign_products == "all_country_products" && user_campaign.link.linked.shop == user_campaign.campaign.shop || user_campaign.campaign.feeds.where(id: user_campaign.link.linked.feed.id).take || user_campaign.campaign.label_1 == user_campaign.link.linked.campaign_label && user_campaign.link.linked.shop == user_campaign.campaign.shop
					true
				end
			end
		end
	end

	def has_account?(order)
		if self.accounts.where(shop_id: order.shop_id).take
			true
		else
			false
		end
	end

	def has_points?(order)
		if self.accounts.where(shop_id: order.shop_id).take.balance >= order.amount
			true
		else 
			false
		end
	end


end
