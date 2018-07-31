class ClickSerializer < ActiveModel::Serializer
  attributes :id, :clicker_id, :winner_id, :pick_id, :product_id, :link, :status, :trigger_time
end
