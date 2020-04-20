require 'chaltron/engine'
require 'syslog'

module Chaltron
  module Controllers
    autoload :Helpers, 'chaltron/controllers/helpers'
  end

  mattr_accessor :roles
  @@roles = %w( admin user_admin )

  mattr_accessor :default_roles
  @@default_roles = []

  mattr_accessor :ldap_allow_all
  @@ldap_allow_all = true

  mattr_accessor :enable_syslog
  @@enable_syslog = false

  mattr_accessor :syslog_facility
  @@syslog_facility = Syslog::LOG_SYSLOG

  mattr_accessor :ldap_field_mappings
  @@ldap_field_mappings = {
    first_name: 'givenname',
    last_name: 'cn',
    department: 'department',
    email: 'mail'
  }

  mattr_accessor :ldap_group_base
  @@ldap_group_base = nil

  mattr_accessor :ldap_group_member_filter
  @@ldap_group_member_filter = -> (entry) { "uniquemember=#{entry.dn}" }

  mattr_accessor :ldap_role_mappings
  @@ldap_role_mappings = {}

  mattr_accessor :ldap_after_authenticate
  @@ldap_after_authenticate = -> (user, ldap) { user }

  mattr_accessor :ldap_before_logout
  @@ldap_before_logout = -> (user, ldap) { }

  mattr_accessor :revision_filename
  @@revision_filename = 'REVISION'

  def self.setup
    yield self
  end
end
