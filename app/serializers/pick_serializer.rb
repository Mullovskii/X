class PickSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :author_type, :body, :mana, :status, :main_image
  
  has_many :media
  has_many :brands
  has_many :products
  has_many :external_links
  has_many :hashtags
  has_many :categories
end
