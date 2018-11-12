class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.integer :mediable_id
      t.string :mediable_type
      t.string :url
      t.integer :kind, default: 0

      t.timestamps
    end
    # add_index :media, [:url, :mediable_id, :mediable_type], unique: true
  end
end
