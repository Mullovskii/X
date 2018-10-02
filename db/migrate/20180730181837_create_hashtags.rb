class CreateHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtags do |t|
      t.string :name
      t.decimal :mana, default: 0, precision: 5, scale: 3

      t.timestamps
    end
  end
end
