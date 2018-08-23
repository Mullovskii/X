class GiftSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :secret, :brand_id, :custom_id, :brand, :main_category_id, :product_type, :product_id, :campaign_id, :product_id, :title, :description, :main_image_link, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :status, :delivery_details, :actions_per_gift, :number_of_gifts, :comment, :additional_secret, :delivery_option
  has_one :shop
  has_one :campaign
  has_one :product
end
