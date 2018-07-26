class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.integer :mediable_id
      t.string :mediable_type
      t.string :url
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
