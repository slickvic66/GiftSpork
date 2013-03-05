class Invitation < ActiveRecord::Base
  attr_accessible :exchange_id, :invited_email, :token, :accepted, 
  :sender_id

  belongs_to :exchange, :inverse_of => :invitations

  # Need sender id to later autofill any emails a user has sent to before via ajax

  belongs_to :sender, 
             :foreign_key => :sender_id, 
             :class_name => "User"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :invited_email, presence: true, uniqueness: { :scope => :exchange_id }, format: { with: VALID_EMAIL_REGEX }
  validates :exchange, presence: true

  before_create :generate_token
  after_create :send_external_or_internal

  private

  def generate_token
    token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def send_external_or_internal
    if is_registered?
      # Create an internal notification and send an email with link to sign_in_path
    else
      # Send and email with link to sign_up_path and create
    end
  end

  def is_registered?
    return true if User.find_by_email(invited_email)
  end
end
