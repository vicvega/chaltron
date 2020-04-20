require 'chaltron/ldap/user'

if defined?(Warden)
  Warden::Manager.after_set_user do |record, warden, options|
    # LDAP callback. Last check before authentication
    if record && record.ldap_user? &&
      Chaltron.ldap_after_authenticate.call(record, Chaltron::LDAP::Connection.new).nil?
      scope = options[:scope]
      warden.logout(scope)
      throw :warden, scope: scope, message: I18n.t('chaltron.not_allowed_to_sign_in')
    end
  end

  # Log after authentication
  Warden::Manager.after_authentication do |user,auth,opts|
    Log.create(
      message: I18n.t('chaltron.logs.login', user: user.display_name),
      category: :login,
      severity: :info
    ) if user
  end

  Warden::Manager.before_logout do |user,auth,opts|
    # LDAP callback
    Chaltron.ldap_before_logout.call(user, Chaltron::LDAP::Connection.new) if user.ldap_user?
    # Log before logout
    Log.create(
      message: I18n.t('chaltron.logs.logout', user: user.display_name),
      category: :login,
      severity: :info
    ) if user
  end
end
