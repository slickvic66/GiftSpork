class AddGiftIdBackToGiftIdeas < ActiveRecord::Migration
  def change
    add_column :gift_ideas, :gift_id, :integer
  end
end
