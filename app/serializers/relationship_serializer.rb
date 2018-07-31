class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :follower_id, :follower_type, :followed_id, :followed_type
end
