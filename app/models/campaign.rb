class Campaign < ApplicationRecord

	enum kind: [:referral, :data_transfer, :purchase]
	enum mode: [:money, :physical_gifts, :virtual_gifts]
	enum status: [:fresh, :submitted, :declined, :ongoing, :stopped, :cancelled, :finished]

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

