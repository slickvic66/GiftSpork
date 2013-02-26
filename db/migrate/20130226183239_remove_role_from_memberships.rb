class RemoveRoleFromMemberships < ActiveRecord::Migration
  def change
    remove_column :memberships, :role 
  end
end
