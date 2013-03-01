class GiftsController < ApplicationController

  def index
    @exchange = Exchange.find(params[:exchange_id])
    @gifts = @exchange.gifts_below_max_price
    @current_gift = current_user.gift_on_current_exchange(@exchange).first
  end

  # REV: Could this be named something different than `add_gift`?
  # Maybe `give`?
  # Pretty hacky.  Ment to be done with AJAX
  def add_gift
    # REV: No, this query is easy in AR; you aren't using AR enough.
    match = Match.find_by_sql(["SELECT matches.* FROM matches WHERE matches.santa_id = :current_user_id AND matches.exchange_id = :this_exchange_id", :current_user_id => current_user.id, 
                          :this_exchange_id => params[:exchange_id]]).first

    if match.update_attributes(gift_id: params[:id])
      flash[:success] = "Gift Selected"
      redirect_to exchange_path(params[:exchange_id])
    else
      flash[:error] = "Gift Not Selected"
      redirect_to exchange_gifts_path(params[:exchange_id])
    end
  end

end
