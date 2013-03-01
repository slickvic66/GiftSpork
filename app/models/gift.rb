class Gift < ActiveRecord::Base
  attr_accessible :category, :color, :name, :picture_url, :price

  has_many :matches

  # REV: throw some validations in.
end


