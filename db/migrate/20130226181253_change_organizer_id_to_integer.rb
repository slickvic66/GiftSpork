class ChangeOrganizerIdToInteger < ActiveRecord::Migration
  def change
    remove_column :exchanges, :organizer_id
    add_column :exchanges, :organizer_id, :integer
  end
end
