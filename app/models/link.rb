class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true
	belongs_to :linked, polymorphic: true, optional: true
	belongs_to :author, polymorphic: true
	has_many :clicks
	has_one :user_campaign
	has_one :campaign, through: :user_campaign
	enum kind: [:product_pick, :brand_pick, :external_link]

	default_scope { order("created_at DESC") }

	after_create :add_to_showroom

	def add_to_showroom
		if self.kind == "product_pick"
			if self.author_type == "User"
				unless self.author.showroom.products.where(id: self.linked_id).take
					ProductShowroom.create(product_id: self.linked_id, showroom_id: self.author.showroom.id) 
				end
			end
		end
	end

end
