class RemoveOrganizerIdFromExchange < ActiveRecord::Migration
  def change
    remove_column :exchanges, :organizer_id
  end
end
