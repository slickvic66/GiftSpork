class AddGiftFieldsToGiftIdea < ActiveRecord::Migration
  def change
    remove_column :gift_ideas, :gift_id
    add_column :gift_ideas, :name, :string
    add_column :gift_ideas, :color, :string
    add_column :gift_ideas, :picture_url, :string
    add_column :gift_ideas, :price, :string
    add_index :gift_ideas, :user_id
    add_index :gift_ideas, :exchange_id
  end
end
