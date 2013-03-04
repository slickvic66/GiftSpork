class Exchange < ActiveRecord::Base
  attr_accessible :exchange_date, :match_date, :name, :max_price, :organizer_id, :matchedup, :invitations_attributes
  
  ############# Associations ##################

  has_many :invitations, :inverse_of => :exchange
  accepts_nested_attributes_for :invitations,
    :reject_if => lambda { |attributes| attributes['invited_email'].blank? }

  belongs_to :organizer, 
             :foreign_key => :organizer_id,
             :class_name => "User"

  has_many :memberships, :dependent => :destroy, 
           :inverse_of => :exchange
  
  has_many :participants, 
           :through => :memberships, 
           :source => :user

  has_many :matches, :dependent => :destroy

  has_many :gifts, :through => :matches

  ############ Validations ####################

  [ 
    :organizer_id,
    :exchange_date,
    :match_date,
    :name,
    :max_price].each{|field| validates field,
                                :presence => true}
  
  validate :match_date_at_least_a_week_away, :on => :create
  validate :updated_match_date_must_be_tomorrow_or_later, 
           :on => :update
  validate :exchange_date_at_least_three_days_after_match_date


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

  def gifts_below_max_price
    Gift.find_by_sql(["SELECT gifts.* FROM gifts WHERE gifts.price <= :max_price", :max_price => self.max_price])
  end

  # Matches Constructor
  def make_santas
    if matchedup
      raise "Already Matched Up"
    end
    
    ps = participants.shuffle

    ps.each_with_index do |participant, i|

      matches.build(:santa_id => participant.id,
                    :recipient_id => ps[(i+1)%ps.length].id)

    end
    self.matchedup = true
    unless save
      raise errors.full_messages
    end
  end
  
end
