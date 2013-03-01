module ExchangesHelper
  # REV: I'd pass in the exchange; otherwise this method doesn't
  # really do that much.
  def is_organizer?(organizer)
     organizer.id == current_user.id
  end
end
