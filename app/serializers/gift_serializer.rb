class GiftSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :secret, :brand_id, :custom_id, :brand, :main_category_id, :product_type, :title, :description, :main_image_link, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :status, :point_price, :number_of_gifts, :number, :comment, :country_id
  has_one :shop
end
