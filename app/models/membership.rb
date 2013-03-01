class Membership < ActiveRecord::Base
  attr_accessible :exchange_id, :user_id
  belongs_to :exchange, :inverse_of => :memberships
  belongs_to :user, :inverse_of => :memberships

  [:user, :exchange].each do |field| 
    validates field, :presence => true
  end

  validates :user_id, :uniqueness => {:scope => :exchange_id }
end
