class AddUrlToGiftIdea < ActiveRecord::Migration
  def change
    add_column :gift_ideas, :url, :string
  end
end
