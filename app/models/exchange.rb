class Exchange < ActiveRecord::Base
  attr_accessible :exchange_date, :match_date, :name, :price, :organizer_id
  #after_create :make_membership

  belongs_to :organizer, 
             :foreign_key => :organizer_id,
             :class_name => "User"

  has_many :memberships, :dependent => :destroy
  
  has_many :participants, 
           :through => :memberships, 
           :source => :user

  has_many :matches, :dependent => :destroy

  has_many :gifts, :through => :matches

  [ 
    :organizer_id,
    :exchange_date,
    :match_date,
    :name,
    :price].each{|field| validates field,
                                :presence => true}
  
  #validate :match_date_at_least_a_week_away, :on => :create
  #validate :updated_match_date_must_be_tomorrow_or_later, 
           #:on => :update
  #validate :exchange_date_at_least_three_days_after_match_date


  # Custom Validators
  def match_date_at_least_a_week_away
    unless match_date >= (Date.today + 7.days)
      errors.add(:match_date, "must be at least a week away")
    end
  end

  def exchange_date_at_least_three_days_after_match_date
    unless exchange_date >= (match_date + 3.days)
      errors.add(:exchange_date, "must be at least 3 days after match date to give people a chance to find gifts.")
    end
  end

  # On update they will be able to make the match date be earlier
  # But 3 days before match, Exchange will lock so no further updates
  def updated_match_date_must_be_tomorrow_or_later
    unless match_date > Date.today
      errors.add(:match_date, "must be set to tomorrow or later")
    end
  end

  # Custom queries
  def get_participant_names
     self.participants.joins(:profile).select('fname, lname')
  end

end
