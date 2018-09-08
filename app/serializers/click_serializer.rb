class ClickSerializer < ActiveModel::Serializer
  attributes :id, :pick_id, :user_id, :link_id, :status, :trigger_time
end
