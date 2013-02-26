class Exchange < ActiveRecord::Base
  attr_accessible :exchange_date, :match_date, :name, :price

  has_many :memberships
  has_many :users, :through => :memberships

  def get_organizer
    self.users.joins(:memberships).where('memberships.role = ?', 'organizer').uniq
  end

  def get_participants
    self.users.joins(:memberships).where('memberships.role = ?', 'participant').uniq
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
end
