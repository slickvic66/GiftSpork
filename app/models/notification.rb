class Notification < ActiveRecord::Base
  # Right now this is just a notification for new invitations but it will be turned polymorphic once I can 
  attr_accessible :associated_id, :kind, :user_id

  belongs_to :user

  belongs_to :invitation,
             :foreign_key => :associated_id,
             :class_name => "Invitation"
end
