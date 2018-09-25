class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.decimal :usd_rate, default: 1, precision: 5, scale: 3
      t.decimal :ruble_rate, default: 0, precision: 5, scale: 3
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
