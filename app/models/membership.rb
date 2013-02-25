class Membership < ActiveRecord::Base
  attr_accessible :exchange_id, :user_id, :role
  belongs_to :exchange
  belongs_to :user 
end
