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
	

	validates :name, uniqueness: true
	validates :legal_name, uniqueness: true, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :website, uniqueness: true, :uniqueness => { :allow_blank => true, :case_sensitive => false }
	validates :registration_number, uniqueness: true, :uniqueness => { :allow_blank => true, :case_sensitive => false }

	enum status: [:user_owned, :brand_owned, :marketplace]
	enum kyc: [:unverified, :in_progress, :verified]

end
