class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable and :omniauthable

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :omniauthable

  validates :username, presence: true, uniqueness: true

  def display_name
    fullname || username
  end

  #
  # Class methods
  #
  class << self
    def build_user(attrs = {})
      User.new(defaults.merge(attrs.symbolize_keys))
    end

    def defaults
      {
      }
    end
  end

end
