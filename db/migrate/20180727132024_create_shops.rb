class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :legal_name
      t.string :description
      t.string :website
      t.integer :business_type
      t.integer :status, default: 0
      t.integer :kyc, default: 0
      t.string :avatar
      t.string :background
      t.integer :main_category_id
      t.integer :main_country_id
      t.integer :main_currency_id
      t.decimal :mana, default: 0, precision: 5, scale: 3
      t.integer :owner_id
      t.string :owner_type
      t.integer :brand_id
      t.integer :registration_number
      t.string :phone
      t.string :email
      t.integer :integration_type
      t.text :payment_rules
      t.boolean :accepted_rules, default: false

      t.timestamps
    end
    add_index :shops, :name, unique: true
    add_index :shops, :legal_name, unique: true
    add_index :shops, :website, unique: true
    add_index :shops, :registration_number, unique: true
  end
end
