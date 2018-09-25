class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :notified_id, :notified_type, :notifier_id, :notifier_type, :kind, :attached_id, :attached_type
end
