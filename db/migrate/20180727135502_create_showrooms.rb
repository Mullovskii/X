class CreateShowrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :showrooms do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :description
      t.decimal :mana, default: 0, precision: 5, scale: 3

      t.timestamps
    end
  end
end
