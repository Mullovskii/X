class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      # t.references :campaign, foreign_key: true
      t.references :currency, foreign_key: true
      t.references :shop, foreign_key: true
      t.boolean :main
      t.float :balance_in_cents, default: 0
      t.integer :kind

      t.timestamps
    end
  end
end
