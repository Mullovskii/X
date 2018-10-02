class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :main_category_id, :description, :avatar, :background, :main_country_id, :status

  has_many :brand_picks
  # has_many :shops

end
