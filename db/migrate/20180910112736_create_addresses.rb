class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :country, foreign_key: true
      t.references :city, foreign_key: true
      t.references :street, foreign_key: true
      t.bigint :owner_id
      t.string :owner_type
      t.text :additional
      t.string :postcode

      t.timestamps
    end
  end
end
