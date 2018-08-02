class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.references :shop, foreign_key: true
      t.references :campaign, foreign_key: true
      t.references :product, foreign_key: true
      t.string :name
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

      t.timestamps
    end
  end
end
