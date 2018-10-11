class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :legal_name
      t.string :description
      t.string :website
      # t.integer :business_type
      t.integer :kind, default: 0
      t.integer :kyc, default: 0
      t.string :avatar
      t.string :background
      # t.integer :category_id
      t.references :country
      # t.integer :currency_id
      t.decimal :mana, default: 0, precision: 5, scale: 3
      t.integer :owner_id
      t.string :owner_type
      t.references :brand
      t.string :brand_name
      # t.integer :registration_number
      t.string :phone
      t.string :customer_email
      t.string :order_email
      t.integer :integration_type, default: 0
      # t.text :payment_rules
      t.boolean :accepted_rules, default: true

      t.timestamps
    end
    add_index :shops, :name, unique: true
    add_index :shops, :legal_name, unique: true
    add_index :shops, :website, unique: true
    # add_index :shops, :registration_number, unique: true
  end
end
