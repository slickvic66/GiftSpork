class GiftIdeasController < ApplicationController
  def create
    @giftidea=GiftIdea.new(params[:giftidea])
    if @giftidea.save
      respond_to do |format|
        # You can't render a string in :json or a 200 header value because jQuery is expecting json on success
        format.json{render :json => @giftidea.id}
      end
    else
      respond_to do |format|
        format.json{render :json => @giftidea.errors, :status => 400}
      end
    end
  end

  def destroy
    @giftidea = GiftIdea.find(params[:id])
    @giftidea.destroy

    # This just highlights that I am sending an html request via ajax and responding to it with json.  If I didn't do this it would throw a 'template missing error'
    respond_to do |format|
      format.html {render :json => @giftidea.id}
    end
  end

end
