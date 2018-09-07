class HashtagSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :picks
  has_many :users
  has_many :shops
end
