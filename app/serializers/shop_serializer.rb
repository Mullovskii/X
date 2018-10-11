class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :accepted_rules, :description, :website, :kind, :avatar, :background, :country_id
  has_many :products
  has_many :picks
  # has_many :active_campaigns
  # has_many :gift_products
  has_many :following
  has_many :followers
  has_one :account
end
