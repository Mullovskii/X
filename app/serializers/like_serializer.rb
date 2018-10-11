class LikeSerializer < ActiveModel::Serializer
  attributes :id, :liker_id, :liker_type, :liked_id, :liked_type
end
