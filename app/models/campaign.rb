class Campaign < ApplicationRecord

	enum kind: [:link_referral, :product_referral, :purchase]
	enum mode: [:gifts, :money]
	enum status: [:fresh, :submitted, :declined, :ongoing, :stopped, :cancelled, :finished]

	belongs_to :shop
	belongs_to :author, polymorphic: true, optional: true

	has_many :links, as: :linking, dependent: :destroy
	has_many :products, through: :links, :source => :linked,
    :source_type => 'Product'
    has_many :feed_campaigns
    has_many :feeds, through: :feed_campaigns

    has_many :user_campaigns
    has_many :users, through: :user_campaigns
    has_many :gifts


end

