# Code that does not work, but I want to learn more about why. 

# My original match code, which caused a cookie overflow (probably because it created too many Matches without saving them)

# From app/controllers/exchanges_controller.rb
  def make_matches
    exchange = Exchange.find_by_id(params[:id])
    ps = exchange.participants.shuffle
    matches = []

    ps.each_with_index do |participant, i|
      if ps[i+1]
        matches << Match.new(santa_id: participant.id, 
                            recipient_id: ps[i+1].id)

      # When index is out of range, give first participant a santa
      else
        matches << Match.new(santa_id: participant.id,
                            recipient_id: ps[0].id)
      end
    end
    begin
      matches.each do |match|
        if match.save
          next
        else
          raise match.errors.full_messages
          break
        end
      end

    rescue Exception => e
      flash[:error] = e
      redirect_to exchange_path(exchange)
    
    else
      flash[:success] = "Participants successfully matched!"
      redirect_to exchange_path(exchange)
    end
  end