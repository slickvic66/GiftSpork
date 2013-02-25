class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @profile = current_user.build_profile()
  end

  def create
    @profile = current_user.build_profile(params[:profile])
    if @profile.save
      redirect_to user_profile_path(current_user)
    else
      render 'new'
    end
  end

  def show
      @profile = Profile.find_by_user_id(params[:user_id])
  end

  def edit
    @profile = Profile.find_by_user_id(current_user.id)
  end

  def update
    @profile = current_user.build_profile(params[:profile])
    if @profile.update_attributes(params[:profile])
      redirect_to user_profile_path(current_user)
    else 
      render 'edit'
    end
  end

end
