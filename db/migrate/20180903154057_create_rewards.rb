class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.references :shop, foreign_key: true
      t.references :country, foreign_key: true
      t.boolean :product_reward
      t.float :point_to_usd, default: 0, precision: 5, scale: 3
      t.float :point_to_lcy, default: 0, precision: 5, scale: 3
      t.references :currency, foreign_key: true
      t.integer :fullfilment_mode
      t.integer :available_products
      t.integer :delivery_mode
      t.integer :gift_delivery_id
      t.boolean :surf_voucher_generation
      t.integer :voucher_use
      t.text :voucher_instruction
      t.boolean :bonus_exchange
      t.float :point_to_bonus, default: 0, precision: 5, scale: 3
      t.integer :bonus_min_time
      t.integer :bonus_max_time
      t.integer :gift_min_time
      t.integer :gift_max_time
      t.text :no_card_instruction
      t.text :other_instruction

      t.timestamps
    end
  end
end
