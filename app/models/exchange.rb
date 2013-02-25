class Exchange < ActiveRecord::Base
  attr_accessible :exchange_date, :match_date, :name, :price

  has_many :memberships
  has_many :users, :through => :memberships
end
