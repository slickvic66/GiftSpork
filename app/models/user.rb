class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_one :profile, :dependent => :destroy
  has_many :memberships
  has_many :exchanges, :through => :memberships

  def exchanges_as_organizer
    self.exchanges.joins(:memberships).where('memberships.role = ?', 'organizer')
  end

  def exchanges_as_participant
    self.exchanges.joins(:memberships).where('memberships.role = ?', 'participant')
  end
end
