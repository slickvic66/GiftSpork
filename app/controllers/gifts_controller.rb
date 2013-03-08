class GiftsController < ApplicationController
  require 'addressable/uri'

  def index
    @exchange = Exchange.find(params[:exchange_id])
    @gifts = @exchange.gifts_below_max_price
    @current_gift = current_user.gift_on_current_exchange(@exchange).first
    @gift_ideas = current_user.gift_ideas_for_exchange(@exchange)
    @etsy_gifts = get_all_listings_for_price(@exchange.max_price/100)["results"]
    @to_display = @etsy_gifts[0..8]
    @hidden_away = @etsy_gifts[9..-1]
  end

  # Pretty hacky.  Meant to be done with AJAX
  def add_gift
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

private

  def get_all_listings_for_price(max_price)
    listings_url = Addressable::URI.new(
      :scheme => "http",
      :host => "openapi.etsy.com",
      :path => "/v2/listings/active",
      :query_values => {
        :api_key => "8kbw5yv1l9lheqod41k3la5r",
        :includes => "MainImage(url_170x135)",
        :fields => "listing_id,title,url,price",
        :max_price => "#{max_price}",
        :limit => "100"
      }
      ).to_s

    final_listings = JSON.parse(RestClient.get(listings_url))

    final_listings
  end

  def get_twelve_gifts_by_page(max_price, page)
    listings_url = Addressable::URI.new(
      :scheme => "http://",
      :host => "openapi.etsy.com",
      :path => "/v2/listings/active",
      :query_values => {
        :api_key => "8kbw5yv1l9lheqod41k3la5r",
        :includes => "MainImage(url_170x135)",
        :fields => "listing_id, title, url, price",
        :limit => "12",
        :max_price => "#{max_price}",
        :page => "#{page}"
      }
      ).to_s

    final_listings = JSON.parse(RestClient.get(listings_url))

    final_listings
  end

end
