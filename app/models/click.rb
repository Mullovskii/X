class Click < ApplicationRecord
	belongs_to :winner, class_name: "User", foreign_key: "winner_id", optional: true
	belongs_to :clicker, class_name: "User", foreign_key: "clicker_id"
	belongs_to :pick
	belongs_to :product
	after_create :add_winner

	enum status: [:off, :on]

	def add_winner
		self.update(winner_id: self.pick.author_id)
	end
end
