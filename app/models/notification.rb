class Notification < ApplicationRecord
	belongs_to :notified, polymorphic: true
	belongs_to :notifier, polymorphic: true
end
