require 'devise'
require 'omniauth'
require 'omniauth-ldap'
require 'bootstrap-sass'
require 'autoprefixer-rails'
require 'font-awesome-sass'

module Chaltron
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
