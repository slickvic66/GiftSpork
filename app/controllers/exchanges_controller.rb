class ExchangesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_participant, :only => [:show]

  def new
    @exchange = Exchange.new()
  end

  def create
    @exchange = Exchange.new(params[:exchange])
    if @exchange.save
      redirect_to exchange_path(@exchange.id)
    else
      render 'new'
    end
  end

  def show
    @exchange = Exchange.find(params[:id])
    @organizer = @exchange.get_organizer
    @participants = @exchange.get_participants
    @organizer_name = @exchange.get_organizer_name
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

  private

  # Makes sure a user is a participant of exchange they try to view
  # Need test for this
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
      unless exchange.list_participant_ids.include?(current_user.id)
         redirect_to user_profile_path(current_user)
      end
    end
  end

end
