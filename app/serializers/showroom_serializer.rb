class ShowroomSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :owner_type, :description, :mana
end
