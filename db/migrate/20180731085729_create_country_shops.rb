class CreateCountryShops < ActiveRecord::Migration[5.1]
  def change
    create_table :country_shops do |t|
      t.references :shop, foreign_key: true
      t.references :country, foreign_key: true
      t.integer :mode

      t.timestamps
    end
  end
end
