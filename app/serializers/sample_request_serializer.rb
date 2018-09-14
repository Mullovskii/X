class SampleRequestSerializer < ActiveModel::Serializer
  attributes :id, :status, :kind, :shop_approval, :user_approval
  has_one :user
  has_one :product
  has_one :shop
  
end
