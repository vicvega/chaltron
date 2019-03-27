require 'chaltron/engine'
require 'chaltron/bootstrap_form'
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

  mattr_accessor :ldap_role_mappings
  @@ldap_role_mappings = {}

  def self.setup
    yield self
  end
end
