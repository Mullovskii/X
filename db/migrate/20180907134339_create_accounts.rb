class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.float :balance, default: 0, precision: 5, scale: 3

      t.timestamps
    end
  end
end
