class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :author_id
      t.string :author_type
      t.integer :linking_id
      t.string :linking_type
      t.integer :linked_id #product/brand/external link
      t.string :linked_type
      t.references :medium, foreign_key: true
      t.bigint :x
      t.bigint :y
      t.string :external_link
      t.integer :kind
      t.integer :status

      t.timestamps
    end
    # add_index :links, [:external_link, :linking_id, :linking_type], unique: true
    add_index :links, [:linked_id, :linked_type, :linking_id], unique: true
  end
end
