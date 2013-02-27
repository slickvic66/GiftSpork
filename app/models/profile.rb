class Profile < ActiveRecord::Base
  attr_accessible :address, :city, :fname, :lname, :phone, :state, :zip, :user_id

  belongs_to :user

  [ :user_id,
    :fname,
    :lname].each{|field| validates field,
                                :presence => true}
                                
end
