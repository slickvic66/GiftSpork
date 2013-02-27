class AddExchangeIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :exchange_id, :integer
  end
end
