Chaltron.setup do |config|
  # If LDAP enabled (see config/initializers/devise.rb), chaltron must use
  # email field and may use first_name, last_name, full_name, department.
  # Here is the field mapping on you own LDAP server.
  # Default values are the following:
  # config.ldap_field_mappings = {
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

  # Here you may specify a different base for your LDAP groups
  # If not specified the :base parameter defined in Devise.omniauth_configs[:ldap] will be used
  # config.ldap_group_base = 'ou=groups,dc=example,dc=com'

  # Here you may specify a filter to retrieve LDAP group membership
  # Accept entry (an instance of Chaltron::LDAP::Person) as parameter
  # Default is
  # config.ldap_group_member_filter = -> (entry) { "uniquemember=#{entry.dn}" }

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
  #
  # Example:
  # config.ldap_after_authenticate = -> (user, ldap) {
  #   ldap.find_by_uid(user.username).entry.enabled == ['true'] ? user : nil
  # }

  # The following callback is called before logout of an LDAP user
  # Takes two parameters:
  #  - user, current instance of User
  #  - ldap, a new instance of Chaltron::LDAP::Connection
  # Default is the following (does nothing)
  # config.ldap_before_logout =  -> (user, ldap) { }
  #
  # Example:
  # config.ldap_before_logout = -> (user, ldap) {
  #   ldap.update_attributes(user.extern_uid, { lastLogout: Time.now.strftime('%Y%m%d%H%M%S%z') })
  # }
  #

  # The content of the following file (if present in Rails.root directory)
  # will be displayed in the footer
  # config.revision_filename = 'REVISION'

  # If syslog enabled, all Log records will be available also in syslog flow
  # config.enable_syslog = false
  # config.syslog_facility = Syslog::LOG_SYSLOG
end
