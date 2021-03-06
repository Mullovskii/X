class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :google_category_id
      t.integer :parent_id
      t.integer :level
      t.decimal :mana, default: 0, precision: 5, scale: 3

      t.timestamps
    end
  end
end
