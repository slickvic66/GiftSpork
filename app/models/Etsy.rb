class Etsy
  def get_all_listings_for_price(max_price)
    listings_url = Addressable::URI.new(
      :scheme => "http://",
      :host => "openapi.etsy.com",
      :path => "/v2/listings/active"
      :query_values => {
        :api_key => "8kbw5yv1l9lheqod41k3la5r",
        :includes => "MainImage(url_170x135)",
        :fields => "listing_id, title, url, price",
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
      :path => "/v2/listings/active"
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

