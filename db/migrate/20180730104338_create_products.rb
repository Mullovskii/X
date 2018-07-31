class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :feed_id #surf
      t.integer :shop_id #surf 
      # t.integer :author_id #surf 
      # t.string :author_type #surf 
      t.integer :status, default: 0 #surf enum
      t.integer :item_id #surf - id of global product card (=Item)
      t.integer :model_id #surf - id of global model card (=Model)
      t.integer :brand_id #surf 
      t.integer :campaign_id #surf - id of unique campaign for product, if varies from feed campaigns
      t.integer :delivery_id #surf - id of product delivery, if varies from feed setting 
      t.integer :venue_id #surf - for events - id of venue
      t.boolean :is_gift #surf - wheather the product is a gift within campaign

      t.integer :custom_id 
      t.string :brand
      
      t.string :title
      t.text :description
      t.string :link
      t.string :main_image_link
      t.string :image_link_0
      t.string :image_link_1
      t.string :image_link_2
      t.string :image_link_3
      t.string :image_link_4
      t.string :image_link_5
      t.string :image_link_6
      t.string :image_link_7
      t.string :image_link_8
      t.string :image_link_9
      t.string :availability
      t.datetime :availability_date
      t.decimal :cost_of_goods_sold
      t.datetime :expiration_date
      t.decimal :price, default: 0, precision: 5, scale: 3
      t.decimal :sale_price, default: 0, precision: 5, scale: 3
      t.text :sale_price_effective_date
      t.string :unit_pricing_measure
      t.string :unit_pricing_base_measure
      t.text :installment
      t.string :loyalty_points
      t.integer :main_category_id
      t.string :product_type
      t.integer :gtin
      t.string :mpn
      t.boolean :identifier_exists
      t.string :condition
      t.boolean :adult
      t.integer :multipack
      t.boolean :is_bundle
      t.string :energy_efficiency_class
      t.string :min_energy_efficiency_class
      t.string :max_energy_efficiency_class
      t.string :age_group
      t.string :color
      t.string :gender
      t.string :material
      t.string :pattern
      t.string :size
      t.string :size_system
      t.string :item_group_id
      t.string :custom_label_0
      t.string :custom_label_1

      t.string :shipping
      t.string :shipping_label
      t.string :shipping_weight
      t.string :shipping_length
      t.string :shipping_width
      t.string :shipping_height
      t.integer :max_handling_time
      t.integer :min_handling_time
      t.string :tax
      t.string :tax_category

      t.string :production_country
      t.integer :barcode 

      t.string :venue

      t.timestamps
    end
  end
end
