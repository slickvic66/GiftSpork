class Exchange < ActiveRecord::Base
  attr_accessible :exchange_date, :match_date, :name, :price
  after_create :make_membership

  has_many :memberships
  has_many :users, :through => :memberships

  validates :exchange_date, :presence => true
  validates :match_date, :presence => true
  validates :name, :presence => true
  validates :price, :presence => true
  
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

  # Custom Queries 
  def get_organizer
    self.users.joins(:memberships).where('memberships.role = ?', 'organizer').uniq
  end

  def get_participants
    self.users.joins(:memberships).where('memberships.role = ?', 'parti  <%= f.date_select :exchange_date %>cipant').uniq
  end

  def get_participant_names
    get_participants.joins(:profile).select('fname, lname')
  end

  def get_organizer_name
    get_organizer.joins(:profile).select('fname, lname')
  end

  def list_participant_ids
    participant_ids = []
    self.users.each do |user|
      participant_ids << user.id
    end

    participant_ids
  end

  private

    def make_membership
      Membership.create(user_id:current_user.id, exchange_id: Exchange.last.id, role: "organizer")
      flash[:success] = "Exchange Successfully Created"
    end
end
