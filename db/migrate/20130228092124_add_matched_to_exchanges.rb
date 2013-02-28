class AddMatchedToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :matchedup, :boolean, :null => false, :default => false
  end
end
