class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true
	belongs_to :linked, polymorphic: true, optional: true
	belongs_to :author, polymorphic: true
	belongs_to :campaign, polymorphic: true, optional: true
	enum kind: [:product_pick, :brand_pick, :external_link]
end
