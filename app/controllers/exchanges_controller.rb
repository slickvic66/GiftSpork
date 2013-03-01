class ExchangesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_participant, :only => [:show]

  def new
    @exchange = Exchange.new()
  end

  def create
    @exchange = Exchange.new(params[:exchange])
    @exchange.organizer_id = current_user.id
    @exchange.max_price *= 100
    # The organizer is also the first member 
    @exchange.memberships.build(user_id:current_user.id)

    # REV: added a space here; got too tight.
    if @exchange.save
      flash[:success] = "Exchange updated"
      redirect_to exchange_path(@exchange.id)
    else
      render 'new'
    end
  end

  def show
    @exchange = Exchange.find(params[:id])
    # REV: you don't need to set all these ivars; just use the
    # association in the view.
    @organizer = @exchange.organizer
    @organizer_profile = @organizer.profile
    @participant_names = @exchange.get_participant_names

    # REV: added a space here; got too tight.
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
  # REV: two blank lines comments in this section are too long.


  # Makes sure a user is a participant or organizer of exchange they try to view
  def check_participant
    # REV: too deeply nested. Don't even need to bother checking if
    # exchange isn't found; just let them get a 404. Their fault for
    # typing something dumb.
    begin
      exchange = Exchange.find(params[:id])

    # If record is not found it will redirect back to profile
    rescue ActiveRecord::RecordNotFound
      if signed_in?
        redirect_to user_profile_path(current_user)
      else
        # REV: okay; time to remove it :-)
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
