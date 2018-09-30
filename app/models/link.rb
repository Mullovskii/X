class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true #pick
	belongs_to :linked, polymorphic: true, optional: true #product/brand/external link
	belongs_to :author, polymorphic: true
	has_many :clicks
	has_one :user_campaign, dependent: :destroy
	has_one :campaign, through: :user_campaign
	enum kind: [:product_pick, :brand_pick, :external_link]
	validates :external_link, uniqueness: { scope: [:linking_id, :linking_type] }
	validates :linked_id, uniqueness: { scope: [:linked_type, :linking_id] }

	default_scope { order("created_at DESC") }

	after_create :add_kind, :add_to_showroom

	def add_kind
		if self.linked_type 
			if self.linked_type == "Product"
				self.kind = "product_pick"
			elsif self.linked_type == "Brand"
				self.kind = "brand_pick"
			end
		else 
			if self.external_link
				self.kind = "external_link"	
			end
		end
		self.save
	end

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
