class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :notified_id
      t.string :notified_type
      t.integer :notifier_id
      t.string :notifier_type
      t.integer :kind
      t.integer :attached_id
      t.string :attached_type

      t.timestamps
    end
  end
end
