class Profile < ActiveRecord::Base
  attr_accessible :address, :city, :fname, :lname, :phone, :state, :zip, :user_id

  belongs_to :user
  validates :user_id, :presence => true
  validates :fname, :presence => true
  validates :lname, :presence => true
end
