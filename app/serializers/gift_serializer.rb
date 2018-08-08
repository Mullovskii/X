class GiftSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :feed_id, :virtual_good, :secret, :brand_id, :custom_id, :brand, :main_category_id, :product_type, :related_product_id, :campaign_id, :product_id, :title, :description, :main_image_link, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :status, :expiration_date, :number_of_units, :delivery_details, :number_of_gifts
  has_one :shop
  has_one :campaign
  has_one :product
end
