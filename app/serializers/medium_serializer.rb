class MediumSerializer < ActiveModel::Serializer
  attributes :id, :mediable_id, :mediable_type, :url, :kind
end
