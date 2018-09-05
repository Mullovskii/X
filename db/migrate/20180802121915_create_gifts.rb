class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.integer :status, default: 0
      t.integer :feed_id #surf gift_feed_id, optional
      t.references :shop, foreign_key: true
      t.references :country, foreign_key: true
      t.string :product_type # ex Women > Dresses > Maxi Dresses
      t.integer :main_category_id #surf -generating later from product_type
      t.integer :custom_id
      t.string :brand
      t.integer :brand_id #surf - generated later from brand
      t.string :title
      t.text :description
      t.string :main_image_link
      t.string :image_link_0
      t.string :image_link_1
      t.string :image_link_2
      t.string :image_link_3
      t.string :image_link_4
      

      t.text :secret
      t.text :comment
      t.bigint :points_per_gift, default: 1
      t.integer :number_of_gifts
      t.integer :number

      t.timestamps
    end
  end
end
