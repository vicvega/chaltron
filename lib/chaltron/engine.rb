module Chaltron
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
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

    initializer('chaltron.controller') do |_app|
      ActiveSupport.on_load(:action_controller) do
        include Chaltron::Controllers::Helpers
        before_action :configure_permitted_parameters, if: :devise_controller?
      end
    end

    initializer('chaltron.simple_navigation') do |_app|
      if defined?(SimpleNavigation)
        SimpleNavigation.config_file_paths << File.expand_path('../../../config', __FILE__)
      end
    end

    initializer('chaltron.bootstrap_form') do |_app|
      if defined?(BootstrapForm)
        require 'chaltron/form_builder/bootstrap_form'
      end
    end

  end
end
