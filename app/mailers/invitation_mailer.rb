class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"

  def invite_to_service(invitation, url)
    @url = url
    @invitation = invitation
    @sender = Profile.find_by_user_id(invitation.sender_id)
    @exchange = Exchange.find(invitation.exchange_id)
    mail(to: invitation.invited_email, 
         subject:"#{@sender.fname} has invited you to join their Gift Exchange")
  end

  def notify_of_invitation(invitation, url)
    @url = url
    @invitation = invitation
    @sender = Profile.find_by_user_id(invitation.sender_id)
    @recipient = User.find_by_email(invitation.invited_email)
    mail(to: invitation.invited_email,
         subject:"#{@sender.fname} invited you to a Gift Exchange")
  end
end
