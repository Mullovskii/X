class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.integer :feed_id #surf gift_feed_id
      t.references :shop, foreign_key: true
      t.references :campaign, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :main_category_id #surf -generating later from product_type
      t.string :product_type # ex Women > Dresses > Maxi Dresses
      t.integer :brand_id #surf 
      t.integer :custom_id
      t.integer :related_product_id # = product.custom_id of associated product
      t.string :brand
      t.string :title
      t.text :description
      t.string :main_image_link
      t.string :image_link_0
      t.string :image_link_1
      t.string :image_link_2
      t.string :image_link_3
      t.string :image_link_4
      t.integer :status, default: 0
      t.datetime :expiration_date
      t.integer :number_of_units
      t.text :delivery_details
      t.boolean :virtual_good
      t.text :secret
      t.integer :number_of_gifts

      t.timestamps
    end
  end
end
