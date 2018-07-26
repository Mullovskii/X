class CreatePicks < ActiveRecord::Migration[5.1]
  def change
    create_table :picks do |t|
      t.integer :author_id
      t.string :author_type
      t.text :body
      t.string :main_image
      t.integer :mana

      t.timestamps
    end
  end
end
