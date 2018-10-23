class Shop < ApplicationRecord
	validates :name, :uniqueness => { :allow_blank => false, :case_sensitive => false }
	validates :legal_name, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :website, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :country_id, presence: true
	belongs_to :owner, polymorphic: true
	belongs_to :brand, optional: true
	belongs_to :country
	has_many :feeds, dependent: :destroy
	has_many :products, dependent: :destroy
	# has_many :campaigns, dependent: :destroy
	has_many :country_shops, dependent: :destroy
	has_many :accounts, dependent: :destroy
	has_many :countries, through: :country_shops
	has_many :deliveries, dependent: :destroy
	has_many :clicks, through: :products
	has_many :employments, dependent: :destroy
	has_many :employees, through: :employments, :source => :user
	# has_many :gifts
	# has_one :reward
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
		if self.country.name == "Russia"
			Account.create(shop_id: self.id, main: true, currency: Currency.where(name: "RUB").first_or_create)	#main_account
			Account.create(shop_id: self.id, main: false, currency: Currency.where(name: "USD").first_or_create)	#supportive_account
		else
			Account.create(shop_id: self.id, main: true, currency: Currency.where(name: "USD").first_or_create)	#main_account
			Account.create(shop_id: self.id, main: false, currency: Currency.where(name: "RUB").first_or_create)	#supportive_account
		end
	end

	def main_account
		self.accounts.where(main: true).take
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
