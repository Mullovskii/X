class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.references :shop, foreign_key: true
      t.references :country, foreign_key: true
      t.integer :mode, default: 0
      t.boolean :weekends_delivery
      t.boolean :holidays_delivery
      t.boolean :pickup

      t.timestamps
    end
  end
end
