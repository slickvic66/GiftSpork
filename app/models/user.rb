class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  attr_accessor :invitation_token


  attr_accessible :email, :password, :password_confirmation, :remember_me, :invitation_token


  after_create :check_invite_and_create_notifications

  has_one :profile, :dependent => :destroy

  ########## Notification/Invitation Associations ###########

  has_many :notifications, :dependent => :destroy

  has_many :recieved_invitations, 
           :through => :notifications,
           :foreign_key => :associated_id

  has_many :sent_invitations,
           :foreign_key => :sender_id,
           :class_name => "Invitation",
           :dependent => :destroy

  ########## Exchange Associations  ########################

  # Joins user and exchange
  has_many :memberships, :dependent => :destroy,
           :inverse_of => :user

  # Returns array of exchanges user is participating in
  has_many :participations, 
           :through => :memberships,
           :source => :exchange

  # Returns array of exchanges user has organized
  has_many :organized_exchanges, 
           :foreign_key => :organizer_id, 
           :class_name => "Exchange",
           :dependent => :destroy

  ########## All Gift-Related Associations ################

  # Past and present matches where user is gift buyer
  has_many :santa_matches,
           :foreign_key => :santa_id,
           :class_name => "Match",
           :dependent => :destroy

  # NEEDS_CHANGE
  # All the gifts this person has ever given OR has selected to give
  has_many :selected_gifts,
           :through => :santa_matches,
           :source => :gift

  # Past and present matches where user is gift recipient
  has_many :recipient_matches,
           :foreign_key => :recipient_id,
           :class_name => "Match",
           :dependent => :destroy

  # NEEDS_CHANGE
  # All the gifts this user has ever recieved OR is set to recieve
  has_many :recieved_gifts,
           :through => :recipient_matches,
           :source => :gift

  # All of the user's gift ideas for various exchanges
  has_many :gift_ideas,
           :dependent => :destroy

  def gift_ideas_for_exchange(exchange_var)
    self.gift_ideas.where([":exchange_id = gift_ideas.exchange_id", 
                            :exchange_id => exchange_var.id])
  end

  # active exchanges user is participating in (post match, pre-ship)
  def active_exchanges
    self.participations.where([':todays_date > match_date 
                               AND :todays_date < exchange_date', 
                               :todays_date => Date.today])
  end

  # upcoming organized_exchange (pre-match)
  def future_organized_exchanges
    self.organized_exchanges.where([':todays_date < match_date', 
                                  :todays_date => Date.today])
  end

  # NEEDS_CHANGE
  def matches_without_gifts  
    self.santa_matches.where("gift_id is NULL")
  end

  def current_santa_matches
    self.santa_matches.joins(:exchange).where([':todays_date > match_date AND :todays_date < exchange_date', :todays_date => Date.today])
  end

  # NEEDS_CHANGE
  # Gifts a user has selected on exchanges that are still open
  def selected_gifts_on_active_exchanges
    Gift.find_by_sql(["Select gifts.* FROM gifts 
                      JOIN matches ON gifts.id = matches.gift_id 
                      JOIN exchanges ON exchanges.id = matches.exchange_id 
                      JOIN memberships ON exchanges.id = memberships.exchange_id 
                      JOIN users ON users.id = memberships.user_id 
                      WHERE exchanges.match_date < :todays_date 
                      AND exchanges.exchange_date > :todays_date 
                      AND users.id = :user_id", 
                      :todays_date => Date.today, 
                      :user_id => self.id])
  end

  # NEEDS_CHANGE
  # Returns gift (if any) a user has selected on a specific exchange
  def gift_on_current_exchange(exchange)
    Gift.find_by_sql(["Select gifts.* FROM gifts 
                      JOIN matches ON gifts.id = matches.gift_id 
                      JOIN exchanges ON exchanges.id = matches.exchange_id 
                      JOIN memberships ON exchanges.id = memberships.exchange_id 
                      JOIN users ON users.id = memberships.user_id 
                      WHERE exchanges.id = :current_exchange_id
                      AND users.id = :user_id", 
                      :current_exchange_id => exchange.id, 
                      :user_id => self.id])
  end

  # NEEDS_CHANGE
  # Exchages that are acvite but a user has not selected a gift for
  def active_exchanges_without_gifts
    Exchange.find_by_sql(["SELECT exchanges.* FROM exchanges  
                          JOIN matches ON exchanges.id = matches.exchange_id 
                          JOIN users ON matches.santa_id = users.id
                          WHERE exchanges.match_date < :todays_date 
                          AND exchanges.exchange_date > :todays_date 
                          AND users.id = :user_id 
                          AND users.id = matches.santa_id
                          AND matches.gift_id is NULL", 
                          :todays_date => Date.today, 
                          :user_id => self.id])
  end

  # Profiles of Users a person is a secret santa for on active exchanges
  def active_recipient_profiles
    Profile.find_by_sql(["SELECT profiles.* 
                         FROM profiles 
                         WHERE profiles.user_id IN 
                         (
                          SELECT users.id 
                          FROM users
                          JOIN matches ON users.id = matches.recipient_id 
                          JOIN exchanges ON matches.exchange_id = exchanges.id
                          WHERE exchanges.match_date < :todays_date 
                          AND exchanges.exchange_date > :todays_date
                          AND matches.santa_id = :user_id)", 
                         :todays_date => Date.today,
                         :user_id => self.id])
  end


  # If person created an account after an invitation look up their invitation and any other invitations they may have. 

  # Invitations are an MD5 hash of the email address the invite is sent to

  def check_invite_and_create_notifications
    if self.invitation_token
      all_invites = []

      # Invites for their specific token
      (Invitation.where("token = ?", self.invitation_token)).each {|invite| all_invites << invite}

      # Any invites for their email (if their email was diff from the one they recieved an invite for)
      Invitation.where("token = ?", Digest::MD5.hexdigest(self.email)).each {|invite| all_invites << invite}

      all_invites.each do |invite|
        Notification.create(user_id:self.id, kind:"invite", associated_id: invite.exchange_id)
      end
    end
  end

  # New matching ALERT

  # New invitation ALERT

  # finished exchanges participated in

  # past gifts given
end
