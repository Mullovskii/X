class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      
      t.string :name
      t.string :description
      t.string :avatar
      t.string :background
      t.integer :main_category_id
      t.integer :main_country_id
      t.integer :status, default: 0
      t.decimal :mana, default: 0, precision: 5, scale: 3

      t.timestamps
    end
      add_index :brands, :name, unique: true
  end
end
