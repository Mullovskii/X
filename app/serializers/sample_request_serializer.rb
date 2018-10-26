class SampleRequestSerializer < ActiveModel::Serializer
  attributes :id, :status, :kind, :address_id, :comment
  has_one :user
  has_one :product
  has_one :shop
  
end
