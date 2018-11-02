class Notification < ApplicationRecord
	belongs_to :notified, polymorphic: true
	belongs_to :notifier, polymorphic: true, optional: true
	belongs_to :currency, optional: true
	enum kind: [:subscription, :reward, :interest, :like, :comment]
	default_scope { order("created_at DESC") }
end
