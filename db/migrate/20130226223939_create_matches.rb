class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :santa_id
      t.integer :recipient_id
      t.integer :gift_id

      t.timestamps
    end
  end
end
