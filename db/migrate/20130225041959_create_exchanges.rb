class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.integer :organizer_id
      t.string :name
      t.date :match_date
      t.date :exchange_date

      t.timestamps
    end
  end
end
