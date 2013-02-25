class Exchange < ActiveRecord::Base
  attr_accessible :exchange_date, :match_date, :name, :organizer_id
end
