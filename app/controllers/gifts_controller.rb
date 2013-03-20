class GiftsController < ApplicationController
  require 'addressable/uri'

  def index
    @exchange = Exchange.find(params[:exchange_id])
    @current_gift = current_user.gift_on_current_exchange(@exchange).first
    @gift_ideas = current_user.gift_ideas_for_exchange(@exchange)
    @etsy_search_results = get_all_listings_for_price(@exchange.max_price/100)["results"]
    @etsy_gifts = Kaminari.paginate_array(@etsy_search_results).page(params[:page]).per(9)
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

end
