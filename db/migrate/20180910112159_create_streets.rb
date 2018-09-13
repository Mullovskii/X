class CreateStreets < ActiveRecord::Migration[5.1]
  def change
    create_table :streets do |t|
      t.references :city, foreign_key: true
      t.text :name
      t.string :postcode
      t.timestamps
    end
  end
end
