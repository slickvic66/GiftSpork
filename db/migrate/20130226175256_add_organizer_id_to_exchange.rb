class AddOrganizerIdToExchange < ActiveRecord::Migration
  def change
    add_column :exchanges, :organizer_id, :string
  end
end
