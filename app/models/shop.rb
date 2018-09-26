class Shop < ApplicationRecord
	belongs_to :owner, polymorphic: true
	belongs_to :brand, optional: true
	has_many :feeds
	has_many :products
	has_many :campaigns
	has_many :country_shops
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
	
	has_many :links, as: :author, dependent: :destroy
	validates :name, :uniqueness => { :allow_blank => false, :case_sensitive => false }
	validates :legal_name, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :website, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :registration_number, :uniqueness => { :allow_blank => true, :case_sensitive => false }

	enum status: [:user_owned, :brand_owned, :marketplace]
	enum kyc: [:unverified, :in_progress, :verified]
	enum integration_type: [:manual, :api]

	after_create :employ_owner

	def employ_owner
		Employment.create(user_id: self.owner_id, shop_id: self.id, status: :approved)
	end

	def active_campaigns
		self.campaigns.where(status: "fresh")
	end

	# def gift_products
	# 	self.products.where(gift_mode: true)
	# end


end
