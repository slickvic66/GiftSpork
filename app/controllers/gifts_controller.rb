class GiftsController < ApplicationController

  def index
    # Select gifts only for the exchange you are in
    @gifts = Gift.all
  end

end
