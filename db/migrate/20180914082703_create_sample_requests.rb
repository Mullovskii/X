class CreateSampleRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :sample_requests do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.references :shop, foreign_key: true
      t.integer :status, default: 0
      t.boolean :shop_approval, default: false
      t.boolean :user_approval, default: false
      t.integer :kind, default: 0

      t.timestamps
    end
    add_index :sample_requests, [:user_id, :product_id], unique: true
  end
end
