class ApplicationController < ActionController::Base
  protect_from_forgery
  include ExchangesHelper
  include ProfilesHelper

  # REV: think this should be in devise controller?
  def after_sign_in_path_for(resource)
    if resource.profile 
      user_profile_path(resource)
    else
      new_user_profile_path(resource)
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
