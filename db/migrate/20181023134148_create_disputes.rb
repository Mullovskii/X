class CreateDisputes < ActiveRecord::Migration[5.2]
  def change
    create_table :disputes do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :reason
      t.string :proof1
      t.string :proof2
      t.string :proof3
      t.string :proof4
      t.string :proof5
      t.text :comment
      t.boolean :shop_agreement
      t.references :address, foreign_key: true
      # t.references :shipping, foreign_key: true
      t.string :parcel_proof1
      t.string :parcel_proof2
      t.string :parcel_proof3
      t.string :parcel_proof4
      t.string :parcel_proof5
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
