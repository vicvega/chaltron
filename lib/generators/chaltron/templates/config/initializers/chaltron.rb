Chaltron.setup do |config|
  # Add new roles to the right and NEVER change role order, or you'll break every role bitmask
  # config.roles = %w( admin user_admin )

  # If ldap enabled (see config/initializers/devise.rb), set this to true to
  # allow every ldap authenitcated users to access you application
  # config.ldap_allow_all = false

  # Default roles granted to new users (if automatically created)
  # config.default_roles = []

  # If syslog enabled, all Log records will be available also in syslog flow
  # config.enable_syslog = false
  # config.syslog_facility = Syslog::LOG_SYSLOG
end
