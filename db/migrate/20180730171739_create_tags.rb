class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.integer :tagger_id
      t.string :tagger_type
      t.integer :tagged_id
      t.string :tagged_type
      t.integer :kind

      t.timestamps
    end
  end
end
