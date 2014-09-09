require 'chaltron/engine'

module Chaltron
  mattr_accessor :roles
  @@roles = %w( admin user_admin )

  def self.setup
    yield self
  end
end
