class AddIndeciesToAllForeginKeys < ActiveRecord::Migration
  def change
    add_index :matches, :santa_id
    add_index :matches, :recipient_id
    add_index :matches, :gift_id
    add_index :matches, :exchange_id

    add_index :memberships, :user_id
    add_index :memberships, :exchange_id

    add_index :profiles, :user_id

    add_index :exchanges, :organizer_id
  end
end
