class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :email, :role, :phone, :description, :instagram, :twitch, :facebook, :avatar, :background, :country_id
  has_many :following
  has_many :followers
  has_many :picks
  has_one :showroom
end