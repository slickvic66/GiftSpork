class GiftIdeasController < ApplicationController
  def create
    @giftidea=GiftIdea.new(params[:giftidea])
    if @giftidea.save
      respond_to do |format|
        # You can't render a string in :json or a 200 header value because jQuery is expecting json on success
        format.json{render :json => true}
      end
    else
      respond_to do |format|
        format.json{render :json => @giftidea.errors, :status => 400}
      end
    end
  end

end
