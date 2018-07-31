class LinkSerializer < ActiveModel::Serializer
  attributes :id, :linking_id, :linking_type, :linked_id, :linked_type, :kind
end
