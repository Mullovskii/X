class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.integer :shop_id
      t.integer :mode
      t.integer :format
      t.integer :target_country_id
      t.integer :content_language
      t.integer :currency
      t.string :name
      t.integer :input_type
      t.string :url
      t.integer :author_id
      t.string :author_type

      t.timestamps
    end
  end
end