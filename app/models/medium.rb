class Medium < ApplicationRecord
	belongs_to :mediable, polymorphic: true
	enum kind: [ :pick_img, :pick_video, :product_img, :product_video ]
	validates :url, uniqueness: { scope: [:mediable_id, :mediable_type] }
end
