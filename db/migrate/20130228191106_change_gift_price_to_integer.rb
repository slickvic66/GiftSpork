class ChangeGiftPriceToInteger < ActiveRecord::Migration
  def change
    remove_column :gifts, :price 
    add_column :gifts, :price, :integer
  end
end
