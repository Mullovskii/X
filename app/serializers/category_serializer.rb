class CategorySerializer < ActiveModel::Serializer
  attributes :id, :level, :name, :google_category_id, :parent_id
end
