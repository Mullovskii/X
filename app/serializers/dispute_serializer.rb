class DisputeSerializer < ActiveModel::Serializer
  attributes :id, :reason, :proof1, :proof2, :proof3, :proof4, :proof5, :comment, :shop_agreement, :status, :parcel_proof1, :parcel_proof2, :parcel_proof3, :parcel_proof4, :parcel_proof5, :status
  has_one :user
  has_one :shop
  has_one :order
  has_one :shipping
  belongs_to :address
end
