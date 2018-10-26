class Comment < ApplicationRecord
	belongs_to :author, polymorphic: true
	belongs_to :commented, polymorphic: true

	after_create :notify_author

	def notify_author
		if self.commented_type == "Pick"
			Notification.create(notified_id: self.commented.author_id, notified_type: self.commented.author_type, notifier_id: self.author_id, notifier_type: self.author_type, kind: "comment", attached_id: self.commented_id, attached_type: "Pick")	
		end
	end
end
