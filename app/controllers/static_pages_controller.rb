class StaticPagesController < ApplicationController
  layout 'homepage'
  def home
    @recent_gifts = Gift.all
    @showing_gifts = @recent_gifts[1..8]
  end

  def contact
  end

  def faq
  end
end
