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
	
	has_many :links, as: :author, dependent: :destroy
	validates :name, :uniqueness => { :allow_blank => false, :case_sensitive => false }
	validates :legal_name, uniqueness: true, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :website, uniqueness: true, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :registration_number, uniqueness: true, :uniqueness => { :allow_blank => true, :case_sensitive => false }

	enum status: [:user_owned, :brand_owned, :marketplace]
	enum kyc: [:unverified, :in_progress, :verified]

	after_create :employ_owner

	def employ_owner
		Employment.create(user_id: self.owner_id, shop_id: self.id, status: :approved)
	end

end
