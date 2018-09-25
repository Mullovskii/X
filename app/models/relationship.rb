class Relationship < ApplicationRecord
	belongs_to :follower, polymorphic: true
	belongs_to :followed, polymorphic: true

	after_create :notify

	def notify
		Notification.create(notified_id: self.followed_id, notified_type: self.followed_type, notifier_id: follower_id, notifier_type: follower_type, kind: "subscription")
	end
	
end
