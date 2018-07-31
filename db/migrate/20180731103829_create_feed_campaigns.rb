class CreateFeedCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_campaigns do |t|
      t.references :feed, foreign_key: true
      t.references :campaign, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
