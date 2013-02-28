class ExchangesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_participant, :only => [:show]

  def new
    @exchange = Exchange.new()
  end

  def create
    @exchange = Exchange.new(params[:exchange])
    @exchange.organizer_id = current_user.id
    # The organizer is also the first member 
    @exchange.memberships.build(user_id:current_user.id)
    if @exchange.save
      flash[:success] = "Exchange updated"
      redirect_to exchange_path(@exchange.id)
    else
      render 'new'
    end
  end

  def show
    @exchange = Exchange.find(params[:id])
    @organizer = @exchange.organizer
    @organizer_profile = @organizer.profile
    @participant_names = @exchange.get_participant_names
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
