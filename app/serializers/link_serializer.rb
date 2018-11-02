class LinkSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :author_type, :linking_id, :linking_type, :linked_id, :linked_type, :kind, :external_link, :medium_id, :x, :y

end
