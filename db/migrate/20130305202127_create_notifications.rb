class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :type
      t.integer :associated_id

      t.timestamps
    end
  end
end
