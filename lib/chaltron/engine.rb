require 'devise'
require 'omniauth'
require 'omniauth-ldap'
require 'bootstrap-sass'
require 'autoprefixer-rails'
require 'font-awesome-sass'
require 'simple-navigation'

require 'simple_navigation_renderers'
SimpleNavigation.config_file_paths << File.expand_path('../../../config', __FILE__)

module Chaltron
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer('chaltron.locales') do |_app|
      Chaltron::Engine.config.i18n.load_path += Dir[root.join('app/views', 'locales', '*.{rb,yml}')]
    end
  end
end
