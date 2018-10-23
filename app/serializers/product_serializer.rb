class ProductSerializer < ActiveModel::Serializer
  attributes :id, :custom_id, :brand_name, :title, :description, :price_in_cents, :currency_id, :sale_price_in_cents, :sale_price_effective_date, :main_category_id, :google_category_id, :product_type, :color, :gender, :material, :size, :size_system, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :image_link_5, :image_link_6, :image_link_7, :image_link_8, :image_link_9,:shipping_length, :shipping_width, :shipping_height

  has_many :picks
  # has_many :active_campaigns
  has_many :product_deliveries

  def product_deliveries
    self.object.deliveries + self.object.shop.deliveries.where(mode: "default").where.not(country_id: self.object.deliveries.map{|d| d.country_id} ) 
  end

end
