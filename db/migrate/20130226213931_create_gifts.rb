class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :price
      t.string :color
      t.string :picture_url
      t.string :category

      t.timestamps
    end
  end
end
