class CreateEmployments < ActiveRecord::Migration[5.1]
  def change
    create_table :employments do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.text :comment
      t.integer :role, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
