class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.references :shop, foreign_key: true
      t.references :order, foreign_key: true
      t.references :dispute, foreign_key: true
      t.integer :provider
      t.string :tracking_number
      t.text :note
      t.boolean :shop_delivery_confirmation
      t.boolean :user_delivery_confirmation
      t.boolean :surf_delivery_confirmation
      t.integer :status, default: 0
      t.integer :kind, default: 0
      t.datetime :delivered_at

      t.timestamps
    end
  end
  # add_index :shippings, [:order_id, :link_id, :pick_id], unique: true
end
