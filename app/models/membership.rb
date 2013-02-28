class Membership < ActiveRecord::Base
  attr_accessible :exchange_id, :user_id
  belongs_to :exchange
  belongs_to :user 

  [:user_id, :exchange_id].each do |field| 
    validates field, :presence => true
  end

  validates :user_id, :uniqueness => {:scope => :exchange_id }
end
