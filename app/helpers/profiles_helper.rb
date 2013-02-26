module ProfilesHelper
  def profile_owner?(profile)
     profile.user_id == current_user.id
    #   return true
    # else
    #   return false
    # end
  end
end
