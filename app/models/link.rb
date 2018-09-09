class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true
	belongs_to :linked, polymorphic: true, optional: true
	belongs_to :author, polymorphic: true
	has_many :clicks
	has_one :user_campaign
	has_one :campaign, through: :user_campaign
	enum kind: [:product_pick, :brand_pick, :external_link]

	default_scope { order("created_at DESC") }
	
end
