class Like < ApplicationRecord
	belongs_to :liker, polymorphic: true 
	belongs_to :liked, polymorphic: true 
	validates :liker_id, uniqueness: { scope: [:liker_type, :liked_id, :liked_type] }
end
