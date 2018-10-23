class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      # t.integer :transaction_id
      t.references :product, foreign_key: true
      t.float :product_price_in_cents
      t.float :shipping_price_in_cents
      t.integer :product_currency_id
      # t.float :usd_price_in_cents
      t.integer :quantity, default: 1
      t.references :shop, foreign_key: true
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true
      t.bigint :phone
      t.integer :status, default: 0
      t.integer :kind, default: 0
      t.float :amount_in_cents
      t.references :currency, foreign_key: true
      t.float :shipping_amount_in_cents
      t.float :total_amount_in_cents
      t.float :vat_in_cents
      t.float :blogger_reward_in_cents
      t.float :surf_reward_in_cents
      t.integer :discount_in_cents
      t.string :psp_payment_id
      t.datetime :paid_at
      t.string :psp_refund_id
      t.datetime :refunded_at
      t.datetime :confirmed_at 
      t.datetime :cancelled_at 

      t.timestamps
    end
  end
end
