require 'simple-navigation'

SimpleNavigation.config_file_paths << File.expand_path('../../../config', __FILE__)

module Chaltron
  class Engine < ::Rails::Engine

    config.app_generators do |g|
      g.templates.unshift File::expand_path('../../templates', __FILE__)
    end

  end
end
