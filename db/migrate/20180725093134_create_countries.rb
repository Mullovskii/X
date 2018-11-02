class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.integer :status
      t.integer :vat
      t.references :currency, foreign_key: true
      
      t.timestamps
    end
  end
end
