class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand_id, :accepted_rules, :legal_name, :order_email, :customer_email, :description, :website, :business_type, :status, :avatar, :background, :main_category_id, :main_country_id, :mana, :registration_number, :phone, :integration_type, :payment_rules, :owner_id, :owner_type
  has_many :products
  has_many :picks
  has_many :active_campaigns
  # has_many :gift_products
  has_many :following
  has_many :followers
end
