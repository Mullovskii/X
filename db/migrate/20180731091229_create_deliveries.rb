class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.string :name
      t.references :shop, foreign_key: true
      t.references :country, foreign_key: true
      t.integer :mode, default: 0
      t.integer :currency_id
      t.boolean :weekends_delivery
      t.boolean :holidays_delivery
      t.boolean :pickup
      t.integer :days_from, default: 0
      t.integer :days_to, default: 1
      t.datetime :timezone

      t.timestamps
    end
  end
end
