class ChangeTypeToKindInNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :type
    add_column :notifications, :kind, :string
  end
end
