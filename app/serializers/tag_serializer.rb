class TagSerializer < ActiveModel::Serializer
  attributes :id, :tagger_id, :tagger_type, :tagged_id, :tagged_type, :kind
end
