class ReplaceExchangePriceDecimalWithString < ActiveRecord::Migration
  def change
    remove_column :exchanges, :price
    add_column :exchanges, :price, :string 
  end
end
