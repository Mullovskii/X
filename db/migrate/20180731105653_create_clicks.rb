class CreateClicks < ActiveRecord::Migration[5.1]
  def change
    create_table :clicks do |t|
      t.integer :clicker_id
      t.integer :winner_id
      t.integer :pick_id
      t.integer :product_id
      t.string :link
      t.integer :status, default: 0
      t.datetime :trigger_time 

      t.timestamps
    end
  end
end
