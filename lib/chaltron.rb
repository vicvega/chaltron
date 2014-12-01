require 'chaltron/engine'

module Chaltron
  module Controllers
    autoload :Helpers, 'chaltron/controllers/helpers'
  end

  mattr_accessor :roles
  @@roles = %w( admin user_admin )

  mattr_accessor :ldap_allow_all
  @@ldap_allow_all = false

  def self.setup
    yield self
  end
end
