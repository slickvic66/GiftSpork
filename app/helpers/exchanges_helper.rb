module ExchangesHelper
  def is_organizer?(organizer)
     organizer.id == current_user.id
    #   return true
    # else
    #   return false
    # end
  end
end
