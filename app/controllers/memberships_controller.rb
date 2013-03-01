class MembershipsController < ApplicationController
  
  # Temp hack to add a bunch of members to exchanges
  def create
    user_id = current_user.id
    # REV: don't need to to_i this
    exchange_id = (params[:exchange_id]).to_i
    membership = Membership.new(user_id: user_id, 
                                exchange_id: exchange_id)
    if membership.save
      redirect_to exchanges_path
      flash[:success] = "Membership created"
    else 
      redirect_to exchanges_path
      flash[:error] = membership.errors.full_messages
    end
  end
end
