Chaltron.setup do |config|
  # Add new roles to the right and NEVER change role order, or you'll break every role bitmask
  # config.roles = %w( admin user_admin )

  # If LDAP enabled (see config/initializers/devise.rb), chaltron must use
  # email field and may use first_name, last_name, full_name, department.
  # Here is the field mapping on you own LDAP server.
  # Default values are the following:
  # {
  #   first_name: 'givenname',
  #   last_name: 'cn',
  #   department: 'department',
  #   email: 'mail'
  # }

  # If LDAP enabled, set this to true to allow every ldap authenitcated
  # users to access you application
  # config.ldap_allow_all = true

  # You may set here default roles granted to new users (if automatically created)
  # config.default_roles = []

  # Roles granted to new users may be retrieved by LDAP group membership.
  # config.ldap_role_mappings = {
  #   'DN_of_LDAP_group1' => 'role1',
  #   'DN_of_LDAP_group2' => 'role2'
  # }

  # The following callback is called after a successful LDAP authentication
  # The callback may manipulate the user instance and
  # must return user if ok, nil if not allowed do login
  # Takes two parameters:
  #  - user, current instance of User
  #  - ldap, a new instance of Chaltron::LDAP::Connection
  # Default is the following (it does nothing and return user)
  # config.ldap_after_authenticate =  -> (user, ldap) { user }

  # If syslog enabled, all Log records will be available also in syslog flow
  # config.enable_syslog = false
  # config.syslog_facility = Syslog::LOG_SYSLOG
end
