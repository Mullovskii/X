class PickSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :author_type, :mana, :status, :main_image, :body
  
  has_many :media
  has_many :brands
  has_many :products
  has_many :external_links
  has_many :hashtags
  has_many :categories
end
