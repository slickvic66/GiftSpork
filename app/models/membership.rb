class Membership < ActiveRecord::Base
  attr_accessible :exchange_id, :user_id
  belongs_to :exchange
  belongs_to :user 

  validates :user_id, :uniqueness => {:scope => :exchange_id }
end
