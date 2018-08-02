class GiftSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :main_image_link, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :status, :expiration_date, :number_of_units, :delivery_details
  has_one :shop
  has_one :campaign
  has_one :product
end
