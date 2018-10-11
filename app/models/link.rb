class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true #pick
	belongs_to :linked, polymorphic: true, optional: true #product/brand/external link
	belongs_to :author, polymorphic: true
	has_many :clicks, dependent: :destroy
	# has_one :user_campaign, dependent: :destroy
	# has_one :campaign, through: :user_campaign
	# validates :external_link, uniqueness: { scope: [:linking_id, :linking_type] }
	validates :linked_id, uniqueness: { scope: [:linked_type, :linking_id] }
	default_scope { order("created_at DESC") }
	enum kind: [:product_pick, :brand_pick]
	enum status: [:unverified, :verified, :cancelled]
	
	after_create :add_kind, :add_to_showroom
	after_update :destroy_from_showroom
	after_destroy :destroy_from_showroom


	def add_kind
		if self.linked_type == "Product"
			self.kind = "product_pick"
		else
			self.kind = "brand_pick"
		end
		self.save
	end

	def add_to_showroom
		if self.kind == "product_pick" && self.author_type == "User"
			ProductShowroom.where(product_id: self.linked_id, showroom_id: self.author.showroom.id).first_or_create
		end
	end

	def destroy_from_showroom
		if self.saved_change_to_status? && self.status == 'cancelled'
			self.product.product_showrooms.where(showroom_id: self.author.showroom.id).take.destroy if self.product.product_showrooms.where(showroom_id: self.author.showroom.id).take
			self.clicks.destroy.all
		end
	end

end
