class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_one :profile, :dependent => :destroy

  has_many :memberships, :dependent => :destroy

  # Returns array of exchanges user is participating in
  has_many :participations, 
           :through => :memberships,
           :source => :exchange

  # Returns array of exchanges user has organized
  has_many :organized_exchanges, 
           :foreign_key => :organizer_id, 
           :class_name => "Exchange"

  has_many :santa_matches,
           :foreign_key => :santa_id,
           :class_name => "Match",
           :dependent => :destroy

  # All the gifts this person has ever given OR has selected to give
  has_many :given_gifts,
           :through => :santa_matches,
           :source => :gift

  has_many :recipient_matches,
           :foreign_key => :recipient_id,
           :class_name => "Match",
           :dependent => :destroy

  # All the gifts this user has ever recieved OR is set to recieve
  has_many :recieved_gifts,
           :through => :recipient_matches,
           :source => :gift

  # These are the gifts a user will be giving in the future
  def gifts_selected
    self.santa_matches.select("gift_id")
  end

  def matches_without_gifts
    self.santa_matches.where("gift_id is NULL")
  end

  # finished exchanges participated in

  # active exchanges participating in (post match, pre-ship)

  # active organized exchanges (post-match, pre-ship)

  # upcoming organized_exchange (pre-match)

  # past gifts given
end
