class Match < ActiveRecord::Base
  attr_accessible :gift_id, :recipient_id, :santa_id, :exchange_id

  belongs_to :exchange
  belongs_to :santa, 
             :foreign_key => :santa_id,
             :class_name => "User"
  belongs_to :recipient,
             :foreign_key => :recipient_id,
             :class_name => "User"

  # This will be called selected_gift and will be through a gift_idea_id (Which I will replace this with)
  belongs_to :gift

  # Validation just for testing purposes
  [ 
    :exchange_id,
    :santa_id,
    :recipient_id].each{|field| validates field,
                                  :presence => true}
end
