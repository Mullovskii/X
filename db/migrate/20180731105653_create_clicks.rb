class CreateClicks < ActiveRecord::Migration[5.1]
  def change
    create_table :clicks do |t|
      t.integer :user_id
      t.integer :pick_id
      t.integer :link_id
      # t.integer :status, default: 0
      t.datetime :trigger_time 
      t.timestamps
    end
    add_index :clicks, [:user_id, :link_id, :pick_id], unique: true
  end
end
