class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :country, foreign_key: true
      t.string :city_name
      t.references :city, foreign_key: true
      t.string :street_name
      t.references :street, foreign_key: true
      t.bigint :owner_id
      t.string :owner_type
      t.string :building
      t.string :apartment
      t.string :postcode
      t.integer :kind

      t.timestamps
    end
  end
end
