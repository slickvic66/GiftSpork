class CreateGiftIdeas < ActiveRecord::Migration
  def change
    create_table :gift_ideas do |t|
      t.integer :user_id
      t.integer :gift_id
      t.integer :exchange_id

      t.timestamps
    end
  end
end
