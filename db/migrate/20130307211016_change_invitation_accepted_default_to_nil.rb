class ChangeInvitationAcceptedDefaultToNil < ActiveRecord::Migration
  def change
    remove_column :invitations, :accepted
    add_column :invitations, :accepted, :boolean, :null => true, :default => nil 
  end
end
