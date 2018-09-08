class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :author_id
      t.string :author_type
      t.integer :linking_id
      t.string :linking_type
      t.integer :linked_id
      t.string :linked_type
      t.references :medium, foreign_key: true
      t.bigint :x
      t.bigint :y
      t.string :external_link
      t.integer :kind

      t.timestamps
    end
  end
end
