class AddIndiciesToExchangeIdAndRecipientEmail < ActiveRecord::Migration
  def change
    add_index :invitations, :exchange_id
    add_index :invitations, :invited_email
    add_index :invitations, :token
  end
end
