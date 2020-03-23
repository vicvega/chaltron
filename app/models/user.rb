class User < ApplicationRecord
  include Authorizable
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable, :timeoutable,
  # :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :validatable, :timeoutable, :trackable, :omniauthable,
         authentication_keys: [:login]

  # Username is already case insensitive.
  # See case_insensitive_keys in config/initializers/devise.rb
  validates :username, presence: true, uniqueness: { scope: :provider }

  # Virtual attribute for authenticating by either username or email
  attr_writer :login

  def login
    @login || username || email
  end

  def display_name
    fullname.presence || username
  end

  # Devise method overridden to allow sign in with email or username
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h)
        .where(['lower(username) = :value OR lower(email) = :value',
                { value: login.downcase }])
        .first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def ldap_user?
    provider == 'ldap'
  end
end
