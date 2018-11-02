class CreateProductShowrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :product_showrooms do |t|
      t.references :product, foreign_key: true
      t.references :showroom, foreign_key: true
      # t.integer :status, default: 0

      t.timestamps
    end
  end
end
