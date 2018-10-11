class Shop < ApplicationRecord
	validates :name, :uniqueness => { :allow_blank => false, :case_sensitive => false }
	validates :legal_name, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :website, :uniqueness => { :allow_blank => true, :case_sensitive => false }

	belongs_to :owner, polymorphic: true
	belongs_to :brand, optional: true
	belongs_to :country
	has_many :feeds
	has_many :products
	has_many :campaigns
	has_many :country_shops
	has_one :account
	has_many :countries, through: :country_shops
	has_many :deliveries
	has_many :clicks, through: :products
	has_many :employments
	has_many :employees, through: :employments, :source => :user
	has_many :gifts
	has_one :reward
	has_many :orders
	has_many :picks, as: :author, dependent: :destroy
	has_many :addresses, as: :owner
	has_many :active_relationships, as: :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, as: :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy  
	has_many :following, through: :active_relationships, :source => :follower,
	    :source_type => 'User'
	has_many :followers, through: :passive_relationships, :source => :followed,
	    :source_type => 'User'
	has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'
    has_many :hashtags, through: :tags, :source => :tagger,
    :source_type => 'Hashtag'
    has_many :shop_brands, through: :tags, :source => :tagger,
    :source_type => 'Brand'
	has_many :links, as: :author, dependent: :destroy
	has_many :likes, as: :liker
	has_many :comments, as: :author
	# validates :registration_number, :uniqueness => { :allow_blank => true, :case_sensitive => false }

	enum kind: [:user_owned, :brand_owned, :marketplace]
	enum kyc: [:unverified, :in_progress, :verified]
	enum integration_type: [:manual, :api]

	after_create :employ_owner, :add_brand, :generate_account

	def employ_owner
		Employment.create(user_id: self.owner_id, shop_id: self.id, status: :approved)
	end

	def generate_account
		if self.country_id
			Account.create(shop_id: self.id, currency_id: self.country.currency.id)	
  		end
	end

	# def active_campaigns
	# 	self.campaigns.where(status: "ongoing")
	# end

	def add_brand
		brand = Brand.where(name: self.brand_name, country_id: self.country_id).first_or_create
  		self.brand_id = brand.id
  		self.save
	end

	# def gift_products
	# 	self.products.where(gift_mode: true)
	# end


end
