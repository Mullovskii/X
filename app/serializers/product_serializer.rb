class ProductSerializer < ActiveModel::Serializer
  attributes :id, :feed_id, :shop_id, :status, :item_id, :model_id, :brand_id, :campaign_id, :delivery_id, :custom_id, :brand, :title, :description, :link, :main_image_link, :availability, :availability_date, :cost_of_goods_sold, :expiration_date, :price, :sale_price, :sale_price_effective_date, :unit_pricing_measure, :unit_pricing_base_measure, :installment, :loyalty_points, :main_category_id, :product_type, :gtin, :mpn, :identifier_exists, :condition, :adult, :multipack, :is_bundle, :energy_efficiency_class, :min_energy_efficiency_class, :max_energy_efficiency_class, :age_group, :color, :gender, :material, :pattern, :size, :size_system, :item_group_id, :custom_label_0, :custom_label_1, :shipping, :shipping_label, :shipping_weight,:shipping_length, :shipping_width,:shipping_height, :max_handling_time, :min_handling_time, :tax, :tax_category, :production_country, :barcode, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :image_link_5, :image_link_6, :image_link_7, :image_link_8, :image_link_9, :venue   
end