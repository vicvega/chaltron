require 'simple-navigation'

SimpleNavigation.config_file_paths << File.expand_path('../../../config', __FILE__)

module Chaltron
  class Engine < ::Rails::Engine
  end
end
