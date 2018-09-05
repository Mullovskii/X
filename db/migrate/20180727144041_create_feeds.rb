class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.integer :shop_id
      t.integer :delivery_id
      t.integer :mode
      t.integer :format
      t.integer :kind
      t.integer :country_id
      t.integer :currency_id
      t.string :name
      t.string :url
      t.boolean :gift_mode
      t.integer :author_id
      t.string :author_type

      t.timestamps
    end
  end
end
