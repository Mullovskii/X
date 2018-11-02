class CreateTariffs < ActiveRecord::Migration[5.1]
  def change
    create_table :tariffs do |t|
      t.references :delivery, foreign_key: true
      t.string :name
      t.integer :mode, default: 0
      t.integer :kind, default: 0
      t.float :product_price_from
      t.float :product_price_to
      t.integer :weight_from
      t.integer :weight_to
      t.integer :unit, default: 0
      t.float :price_in_cents
      t.integer :currency_id

      t.timestamps
    end
  end
end
