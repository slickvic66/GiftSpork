class ChangeExchangePriceToMaxPrice < ActiveRecord::Migration
  def change
    remove_column :exchanges, :price 
    add_column :exchanges, :max_price, :integer, :null => false, :default => 0
  end
end
