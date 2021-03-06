class CreateSwaps < ActiveRecord::Migration[5.1]
  def change
    create_table :swaps do |t|
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.integer :amount_in_cents
      t.float :bonuses
      t.references :shop, foreign_key: true
      t.integer :status, default: 0
      t.bigint :card_number

      t.timestamps
    end
  end
end
