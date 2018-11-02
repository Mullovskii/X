class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :avatar, :background, :country_id

  has_many :brand_picks
  # has_many :shops

end
