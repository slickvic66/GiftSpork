class Profile < ActiveRecord::Base
  attr_accessible :address, :city, :fname, :lname, :phone, :state, :zip

  belongs_to :user
  validates :fname, :presence => true
  validates :lname, :presence => true
end
