class Like < ApplicationRecord
	belongs_to :liker, polymorphic: true 
	belongs_to :liked, polymorphic: true 
	validates :liker_id, uniqueness: { scope: [:liker_type, :liked_id, :liked_type] }

	after_create :notify_author

	def notify_author
		Notification.create(notified_id: self.liked.author_id, notified_type: self.liked.author_type, notifier_id: self.liker_id, notifier_type: self.liker_type, kind: "like", attached_id: self.liked_id, attached_type: "Pick")
	end

end
