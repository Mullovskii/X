class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :transaction_id
      t.integer :ordered_id
      t.string :ordered_type
      t.references :shop, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status
      t.integer :kind
      t.float :amount
      t.datetime :confirmed_at 
      t.datetime :cancelled_at 

      t.timestamps
    end
  end
end
