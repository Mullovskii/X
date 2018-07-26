class CreatePicks < ActiveRecord::Migration[5.1]
  def change
    create_table :picks do |t|
      t.integer :author_id
      t.string :author_type
      t.text :body
      t.string :main_image
      t.decimal :mana, default: 0, precision: 5, scale: 3

      t.timestamps
    end
  end
end
