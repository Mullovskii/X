class CommentSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :author_type, :commented_id, :commented_type, :body, :url
end
