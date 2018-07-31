class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true
	belongs_to :linked, polymorphic: true
	enum kind: [:pick_link, :gift_link]
end
