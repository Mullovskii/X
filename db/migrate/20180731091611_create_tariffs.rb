class CreateTariffs < ActiveRecord::Migration[5.1]
  def change
    create_table :tariffs do |t|
      t.references :delivery, foreign_key: true
      t.integer :mode
      t.decimal :price_from, default: 0, precision: 5, scale: 3
      t.decimal :price_to, default: 0, precision: 5, scale: 3
      t.decimal :weight_from, default: 0, precision: 5, scale: 3
      t.decimal :weight_to, default: 0, precision: 5, scale: 3
      t.integer :days, default: 0
      t.decimal :price, default: 0, precision: 5, scale: 3
      t.integer :currency_id

      t.timestamps
    end
  end
end
