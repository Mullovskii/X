class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true
	belongs_to :linked, polymorphic: true
	belongs_to :author, polymorphic: true
	enum kind: [:product_pick, :brand_pick]
end
