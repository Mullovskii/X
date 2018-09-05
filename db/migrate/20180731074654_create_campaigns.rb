class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.integer :shop_id
      t.integer :author_id
      t.string :author_type
      t.integer :status, default: 0
      t.string :name
      t.integer :country_id
      t.integer :kind, default: 0
      t.boolean :link_referral
      t.string :link_1
      t.string :link_2
      t.string :link_3
      t.string :link_4
      t.string :link_5
      t.float :points_per_referral, default: 0, precision: 5, scale: 3
      t.boolean :product_tagging
      t.float :points_per_tag, default: 0, precision: 5, scale: 3
      t.integer :campaign_products, default: 0
       t.string :label_1
      t.string :label_2
      t.string :label_3
      # t.date :start_date
      # t.date :end_date
      # t.integer :followers_threshold, default: 0
      # t.boolean :read_user_data
      
      
      # t.boolean :product_reward, default: false
      # t.float :point_to_usd, default: 0, precision: 5, scale: 3
      # t.float :point_to_lcy, default: 0, precision: 5, scale: 3
      # t.integer :currency_id
      # t.integer :delivery_option, default: 0
      # t.integer :delivery_id
      # t.integer :available_gifts, default: 0
      # t.integer :coupon_mode
      # t.boolean :custom_coupons, default: false
      # t.text :coupon_details

      # t.boolean :bonus_reward, default: false
      # t.float :point_to_bonus, default: 0, precision: 5, scale: 3
      # t.text :bonus_instructions

      # t.boolean :fee_reward, default: false
      
      
      
     


      t.timestamps
    end
  end
end
