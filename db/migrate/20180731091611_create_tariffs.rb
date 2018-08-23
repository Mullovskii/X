class CreateTariffs < ActiveRecord::Migration[5.1]
  def change
    create_table :tariffs do |t|
      t.references :delivery, foreign_key: true
      t.string :name
      t.integer :mode, default: 0
      t.integer :kind, default: 0
      t.integer :product_price_from
      t.integer :product_price_to
      t.integer :weight_from
      t.integer :weight_to
      t.integer :unit, default: 0
      t.decimal :price, default: 0, precision: 5, scale: 3

      t.timestamps
    end
  end
end
