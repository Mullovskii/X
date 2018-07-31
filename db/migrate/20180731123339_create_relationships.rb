class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.string :follower_type
      t.integer :followed_id
      t.string :followed_type

      t.timestamps
    end
  end
end
