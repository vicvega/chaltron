require 'devise'
require 'cancancan'
require 'omniauth'
require 'omniauth-ldap'
require 'bootstrap-sass'
require 'autoprefixer-rails'
require 'font-awesome-sass'
require 'simple-navigation'
require 'jquery-datatables-rails'
require 'ajax-datatables-rails'
require 'bootstrap_form'
require 'nprogress-rails'
require 'rails-i18n'
require 'momentjs-rails'

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

    config.app_generators do |g|
      g.templates.unshift File::expand_path('../../templates', __FILE__)
    end

    initializer('chaltron.locales') do |_app|
      Chaltron::Engine.config.i18n.load_path += Dir[root.join('app/views', 'locales', '*.{rb,yml}')]
      Chaltron::Engine.config.i18n.load_path += Dir[root.join('app/models', 'locales', '*.{rb,yml}')]
    end

    initializer('chaltron.helpers') do |_app|
      ActiveSupport.on_load(:action_controller) do
        include Chaltron::Controllers::Helpers
      end
    end
  end
end
