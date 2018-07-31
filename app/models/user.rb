class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	         :recoverable, :rememberable, :trackable, :validatable

	enum role: [ :swimming_pool_baby, :swimming_coach, :versed_surfer, :god ]

	has_many :picks, as: :author, dependent: :destroy
	has_one :shop, as: :owner
	has_one :showroom, as: :owner
	has_many :winner_clicks, class_name: "Click", foreign_key: "winner_id"
	has_many :my_clicks, class_name: "Click", foreign_key: "clicker_id"

	has_many :user_campaigns
	has_many :campaigns, through: :user_campaigns

	after_create :generate_showroom

	has_many :active_relationships, as: :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, as: :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

	  
	has_many :following, through: :active_relationships, :source => :follower,
	    :source_type => 'User'
	has_many :followers, through: :passive_relationships, :source => :followed,
	    :source_type => 'User'

    has_many :employments
    has_many :jobs, through: :employments, :source => :shop



	def generate_showroom
		Showroom.create(owner_id: self.id, owner_type: self.class.to_s)
	end

end
