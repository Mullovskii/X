class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :liker_id
      t.string :liker_type
      t.integer :liked_id
      t.string :liked_type

      t.timestamps
    end
    add_index :likes, [:liker_id, :liker_type, :liked_id, :liked_type], unique: true, name: 'check_likes'
  end
end
