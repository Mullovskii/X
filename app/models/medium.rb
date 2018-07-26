class Medium < ApplicationRecord
	belongs_to :mediable, polymorphic: true
	enum kind: [ :pick_img, :pick_video, :product_img, :product_video, :user_avatar, :background ]
end
