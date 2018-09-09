class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :purchased_id
      t.string :purchased_type
      t.float :amount, default: 0, precision: 5, scale: 3
      t.integer :status, default: 0
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
