class PickSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :author_type, :body, :mana, :status, :main_image
end
