class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.integer :shop_id
      t.string :name
      t.integer :kind, default: 0
      t.integer :mode, default: 1
      t.integer :status, default: 0
      t.decimal :bid_per_action, default: 0, precision: 5, scale: 3
      t.integer :currency_id
      t.integer :actions_per_gift, default: 0
      t.integer :gift_id
      t.integer :number_of_gifts
      t.integer :followers_threshold, default: 0

      t.timestamps
    end
  end
end
