class ProductShowroomSerializer < ActiveModel::Serializer
  attributes :id, :status, :product_id, :showroom_id
  has_one :product
  has_one :showroom
end
