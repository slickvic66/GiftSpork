module ExchangesHelper
  def is_organizer?(organizer)
     organizer.id == current_user.id
  end
end
