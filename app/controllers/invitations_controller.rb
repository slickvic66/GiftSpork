class InvitationsController < ApplicationController

  # Have an observer notify the creator of the exchange taht their invitation was accepted

  def accept_invite
    invitation = Invitation.find(params[:id])
    
    # 3 Stages after invite is accepted all must succeed for transaction to succeed.
    begin
      invitation.transaction do
        # Stage 1 Update the invitation itself
        invitation.update_attributes!(:accepted => true)

        # Stage 2 Create a new membership within the exchange
        Membership.create!(:user_id => params[:user_id], 
                           :exchange_id => invitation.exchange_id)

        # Stage 3 Mark the associated notification as seen (even if it already was)
        invitation.notification.update_attributes!(:seen => true)
        # If its successful then flash success and redirect to exchange
      end 

    redirect_to exchange_path(invitation.exchange_id)
    flash[:success] = "Invitation accepted"
    
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Accept Failed"
      redirect_to user_profile_path(params[:user_id])
    end
  end


  # Have an observer notify the creator of the exchange that their invitation was denied

  def deny_invite
    invitation = Invitation.find(params[:id])
    begin
      invitation.transaction do 
          invitation.update_attributes!(:accepted => false)
          invitation.notification.update_attributes!(:seen => true)
      end

    # Using the flash warning here to let them know its bad to deny people's invitations
    flash[:warning] = "Invitation declined."
    redirect_to user_profile_path(params[:user_id])

    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Deny failed"
      redirect_to user_profile_path(params[:user_id])
    end
  end

end
