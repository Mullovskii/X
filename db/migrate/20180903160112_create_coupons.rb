class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.references :shop, foreign_key: true
      t.references :country, foreign_key: true
      t.references :currency, foreign_key: true
      t.integer :kind
      t.integer :discount_mode
      t.integer :discount
      t.integer :discount_products
      t.integer :additional_info
      t.integer :coupon_use
      t.text :instruction
      t.string :background
      t.float :point_price, default: 0, precision: 5, scale: 3
      t.string :secret
      t.integer :number_of_coupons
      t.integer :number
      t.integer :parent_id
      t.integer :status, default: 0
      t.integer :buyer_id
      t.integer :purchased_at
      t.integer :utilized_at

      t.timestamps
    end
  end
end
