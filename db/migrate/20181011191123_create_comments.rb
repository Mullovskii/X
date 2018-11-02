class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.string :author_type
      t.integer :commented_id
      t.string :commented_type
      t.text :body
      t.string :url

      t.timestamps
    end
  end
end
