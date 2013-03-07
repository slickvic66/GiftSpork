class GiftIdea < ActiveRecord::Base
  attr_accessible :exchange_id, :gift_id, :user_id, :name, :price, :category, :color, :picture_url

  belongs_to :user
  belongs_to :exchange

  validates :gift_id, :uniqueness => {:scope => :user_id}
end
