class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.integer :shop_id
      t.integer :author_id
      t.string :author_type
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :country_id
      t.integer :currency_id
      t.boolean :read_user_data
      t.integer :target, default: 0
      t.integer :reward, default: 0
      t.integer :status, default: 0
      t.integer :swap_option, default: 0
      t.text :swap_details
      t.decimal :bonus_per_click, default: 0, precision: 5, scale: 3
      t.integer :followers_threshold, default: 0
      t.string :link_1
      t.string :link_2
      t.string :link_3
      t.string :link_4
      t.string :link_5
      t.boolean :labeled
      t.string :label_1
      t.string :label_2
      t.string :label_3


      t.timestamps
    end
  end
end
