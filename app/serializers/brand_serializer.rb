class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :mana, :main_category_id, :description, :avatar, :background, :main_country_id, :status
end
