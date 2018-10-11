class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :feed_id #surf
      t.integer :country_id #surf
      t.integer :shop_id #surf 
      t.string :custom_id 
      # t.integer :author_id #surf 
      # t.string :author_type #surf 
      #future
      t.integer :status, default: 0 #surf enum
      # t.integer :item_id #surf - id of global product card (=Item)
      # t.integer :model_id #surf - id of global model card (=Model)
      t.string :venue
      t.integer :venue_id #surf - for events - id of venue - taken from venue name above
      #future
      
      t.string :brand_name #name is passed for .xlsx import. Surf checks if the brand is in the DB (if not - creates) + updates brand_id
      t.integer :brand_id #surf 
      
      t.string :title
      t.text :description
      t.string :link
      # t.string :main_image_link
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
      t.float :price, default: 0, precision: 5, scale: 3
      t.references :currency
      t.float :sale_price, default: 0, precision: 5, scale: 3
      t.date :sale_price_effective_date
      t.integer :quantity
      # t.float :shipping_price, default: 0, precision: 5, scale: 3
      # t.integer :shipping_currency_id
      # t.float :point_price, default: 0, precision: 5, scale: 3
      t.string :availability
      t.date :availability_date
      t.date :expiration_date
      t.decimal :cost_of_goods_sold
      t.string :unit_pricing_measure
      t.string :unit_pricing_base_measure
      t.text :installment
      t.string :loyalty_points
      t.integer :main_category_id #surf -generating later from product_type
      t.integer :google_category_id
      t.string :product_type # ex Women > Dresses > Maxi Dresses
      t.string :gtin
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
      
      # t.string :shipping
      # t.string :shipping_label
      t.string :shipping_weight
      t.string :shipping_length
      t.string :shipping_width
      t.string :shipping_height
      t.integer :max_handling_time
      t.integer :min_handling_time
      t.string :tax
      t.string :tax_category

      t.string :production_country
      t.string :barcode 
      
      t.string :campaign_label
      # t.boolean :gift_mode, default: false
      t.boolean :sample_mode, default: false
      t.bigint :sample_threshold, default: 0

      t.timestamps
    end
  end
end
