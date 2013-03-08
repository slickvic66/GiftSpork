class GiftIdea < ActiveRecord::Base
  attr_accessible :exchange_id, :gift_id, :user_id, :name, :price, :category, :color, :picture_url, :url

  belongs_to :user
  belongs_to :exchange

  # A user cant have the same item be a gift idea on the same exchange
  validates :gift_id, 
            :uniqueness => {:scope => [:user_id, :exchange_id]}
end
