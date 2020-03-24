class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role?(:user_admin)
      can :manage, User
      if Chaltron.ldap_allow_all
        cannot :edit, User, { provider: 'ldap' }
        cannot :destroy, User, { provider: 'ldap' }
      end
      can :read, Log, category: 'user_admin'
    end
    if user.has_role?(:admin)
      can :read, Log
    end
  end
end
