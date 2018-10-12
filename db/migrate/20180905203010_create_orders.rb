class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      # t.integer :transaction_id
      t.references :product, foreign_key: true
      t.integer :quantity, default: 1
      t.references :shop, foreign_key: true
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true
      t.references :currency, foreign_key: true
      t.bigint :phone
      t.integer :status, default: 0
      t.integer :kind, default: 0
      t.float :amount, default: 0, precision: 5, scale: 3
      t.float :shipping_amount, default: 0, precision: 5, scale: 3
      t.float :total_amount, default: 0, precision: 5, scale: 3
      t.float :vat, default: 0, precision: 5, scale: 3
      t.float :blogger_reward, default: 0, precision: 5, scale: 3
      t.float :surf_reward, default: 0, precision: 5, scale: 3
      t.float :discount, default: 0, precision: 5, scale: 3
      t.datetime :confirmed_at 
      t.datetime :cancelled_at 

      t.timestamps
    end
  end
end
