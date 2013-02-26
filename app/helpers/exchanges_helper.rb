module ExchangesHelper
  def is_organizer?(exchange_organizer)
     if exchange_organizer.id == current_user.id
      return true
    else
      return false
    end
  end
end
