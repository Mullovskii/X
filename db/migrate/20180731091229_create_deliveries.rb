class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.string :name
      t.references :shop, foreign_key: true
      t.references :product, foreign_key: true
      t.references :country, foreign_key: true
      t.integer :mode, default: 0
      t.boolean :weekends_delivery
      t.boolean :holidays_delivery
      t.boolean :pickup
      t.integer :days_from, default: 0
      t.integer :days_to, default: 1
      t.float :price_in_cents
      t.integer :currency_id
      t.datetime :timezone

      t.timestamps
    end
    add_index :deliveries, [:product_id, :shop_id, :country_id], unique: true
  end
end
