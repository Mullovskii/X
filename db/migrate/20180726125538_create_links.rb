class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :linking_id
      t.string :linking_type
      t.integer :linked_id
      t.string :linked_type
      t.string :external_link

      t.timestamps
    end
  end
end