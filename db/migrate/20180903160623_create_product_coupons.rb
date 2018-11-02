class CreateProductCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :product_coupons do |t|
      t.references :product, foreign_key: true
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
