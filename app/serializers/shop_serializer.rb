class ShopSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand_id, :legal_name, :description, :website, :business_type, :status, :avatar, :background, :main_category_id, :main_country_id, :mana, :registration_number, :phone, :integration_type, :payment_rules, :owner_id, :owner_type
end
