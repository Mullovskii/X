class Campaign < ApplicationRecord

	enum target: [:link, :product, :purchase]
	enum product_target: [:all_products, :feed, :labeled]
	enum reward: [:bonus, :gift, :fee]
	enum status: [:fresh, :submitted, :declined, :ongoing, :stopped, :cancelled, :finished]
	enum swap_option: [:request_swap, :automatic_swap]

	belongs_to :shop
	belongs_to :author, polymorphic: true, optional: true

	# has_many :links, as: :linking, dependent: :destroy
	has_many :links, as: :linked, dependent: :destroy
	has_many :products, through: :links, :source => :linked,
    :source_type => 'Product'
    has_many :feed_campaigns
    has_many :feeds, through: :feed_campaigns

    has_many :user_campaigns
    has_many :users, through: :user_campaigns
    has_many :gifts


end

