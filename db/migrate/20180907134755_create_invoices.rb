class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :account, foreign_key: true
      t.references :campaign, foreign_key: true
      t.references :shop, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :payment_method, default: 0
      t.float :amount, default: 0, precision: 5, scale: 3
      t.references :currency, foreign_key: true
      t.integer :vat
      t.string :custom_id
      t.integer :status, default: 0
      t.integer :kind, default: 0
      t.bigint :card_number

      t.timestamps
    end
  end
end
