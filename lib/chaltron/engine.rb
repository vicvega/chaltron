require 'simple-navigation'
require 'bootstrap_form'
require 'autoprefixer-rails'
require 'nprogress-rails'
require 'rails-i18n'
require 'devise'
require 'cancancan'
require 'omniauth'
require 'omniauth-ldap'
require 'ajax-datatables-rails'

SimpleNavigation.config_file_paths << File.expand_path('../../../config', __FILE__)

module Chaltron
  class Engine < ::Rails::Engine

    config.app_generators do |g|
      g.templates.unshift File.expand_path('../../templates', __FILE__)
    end

    initializer('chaltron.locales') do |_app|
      Chaltron::Engine.config.i18n.load_path += Dir[root.join('app/views', 'locales', '*.{rb,yml}')]
      Chaltron::Engine.config.i18n.load_path += Dir[root.join('app/models', 'locales', '*.{rb,yml}')]
    end

    initializer('chaltron.helpers') do |_app|
      ActiveSupport.on_load(:action_controller) do
        include Chaltron::Controllers::Helpers
        before_action :configure_permitted_parameters, if: :devise_controller?
      end
    end
  end
end
