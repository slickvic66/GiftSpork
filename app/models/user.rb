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

  has_many :participationships, 
           :through => :memberships,
           :source => :exchange

  has_many :organized_exchanges, 
           :foreign_key => :organizer_id, 
           :class_name => "Exchange"

  # past organized_exchanges

  # upcoming organized_exchanges

  # past participationships

  # upcoming participationships
end
