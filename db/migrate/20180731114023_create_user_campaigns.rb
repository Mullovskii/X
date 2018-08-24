class CreateUserCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :user_campaigns do |t|
      t.references :user, foreign_key: true
      t.references :campaign, foreign_key: true
      t.references :link, foreign_key: true
      t.integer :gift_id

      t.integer :status, default: 0

      t.timestamps
    end
  end
end
