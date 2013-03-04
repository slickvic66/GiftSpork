class AddColumnAcceptedIntoInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :accepted, :boolean, :default => false
  end
end
