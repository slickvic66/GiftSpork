class ExchangesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_participant, :only => [:show]

  def new
    @exchange = Exchange.new()
    3.times { @exchange.invitations.build }
  end

  def create
    @exchange = Exchange.new(params[:exchange])
    @exchange.organizer_id = current_user.id
    @exchange.max_price *= 100

    # The creator of the exchange sends out the invitations
    @exchange.invitations.each do |invitation|
      invitation.sender_id = current_user.id
    end

    # The organizer is also the first member 
    @exchange.memberships.build(user_id:current_user.id)

    if @exchange.save
      flash[:success] = "Exchange created!"
      @exchange.invitations.each do |invitation|
        if invitation.is_registered?
          InvitationMailer.notify_of_invitation(invitation,new_user_session_url).deliver
        else
          InvitationMailer.invite_to_service(invitation, new_user_registration_url(:invitation_id => invitation.token)).deliver
        end
      end
      redirect_to exchange_path(@exchange.id)
    else
      if @exchange.invitations.count < 3
        3.times { @exchange.invitations.build }
      end
      render 'new'
    end
  end

  def show
    @exchange = Exchange.find(params[:id])
    @organizer = @exchange.organizer
    @organizer_profile = @organizer.profile
    @participant_names = @exchange.get_participant_names
    if @exchange.matchedup
      @current_match = @exchange.matches.where('santa_id = :user_id', :user_id => current_user.id)
      @current_recipient = @current_match.first.recipient 
      @current_recipient_profile = @current_recipient.profile
      @current_gift = @current_match.first.gift
    end
  end

  def edit
    @exchange = Exchange.find(params[:id])
  end

  def update
    @exchange = Exchange.find(params[:id])
    if @exchange.update_attributes(params[:exchange])
      flash[:success] = "Exchange updated!"
      redirect_to exchange_path(@exchange)
    else
      render 'edit'
    end
  end

  def destroy
    @exchange = Exchange.find(params[:id])
    @exchange.destroy
    redirect_to user_profile_path(current_user)
  end

  def make_matches
    exchange = Exchange.find_by_id(params[:id])
    begin
      exchange.make_santas
    rescue Exception => e
      flash[:error] = e.to_s
      redirect_to exchange_path(exchange)
    else
      flash[:success] = "Participants successfully matched!"
      redirect_to exchange_path(exchange)
    end
  end

  def index
    @exchanges = Exchange.all
    @currently_participating = current_user.participations
    @new_exchanges = @exchanges - @currently_participating
  end

  private


  # Makes sure a user is a participant or organizer of exchange they try to view
  def check_participant
    begin
      exchange = Exchange.find(params[:id])

    # If record is not found it will redirect back to profile
    rescue ActiveRecord::RecordNotFound
      if signed_in?
        redirect_to user_profile_path(current_user)
      else
        # Unecessary check because this is already checked for by :authenticate_user!
        redirect_to root_path
      end
    end

    if exchange
      unless exchange.participants.map{|p| p.id}.include?(current_user.id)
         redirect_to user_profile_path(current_user)
      end
    end
  end

end