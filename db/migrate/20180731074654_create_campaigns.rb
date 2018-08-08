class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.integer :shop_id
      t.integer :author_id
      t.string :author_type
      t.string :name
      t.boolean :read_user_data
      t.integer :kind, default: 0
      t.integer :mode, default: 1
      t.integer :status, default: 0
      t.decimal :bid_per_action, default: 0, precision: 5, scale: 3
      t.integer :currency_id
      t.integer :actions_per_gift, default: 0
      t.integer :followers_threshold, default: 0
      t.string :link_1
      t.string :link_2
      t.string :link_3
      t.string :link_4
      t.string :link_5


      t.timestamps
    end
  end
end
