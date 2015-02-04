class User < ActiveRecord::Base
  include Authorizable
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :lockable and :omniauthable

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :omniauthable

  validates :username, presence: true, uniqueness: { scope: :provider }

  def display_name
    fullname.presence || username
  end

end
