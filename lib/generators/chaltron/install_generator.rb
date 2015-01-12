require 'rails/generators'
require 'chaltron/banner'

module Chaltron
  # Install a skeleton application
  class InstallGenerator < Rails::Generators::Base
    desc 'Install a chaltron skeleton application'
    source_root File.expand_path('../templates', __FILE__)
    class_option :interactive, type: :boolean, desc: 'Run interactive configuration.', default: true

    def disclaimer
      print_banner
      if options.interactive?
        exit unless yes?('Are you sure you want to continue? [yes/NO]')
      end
    end

    def install_gems
      # test
      gem_group :development, :test do
        gem 'rspec-rails'
        gem 'capybara'
        gem 'factory_girl_rails'
        gem 'shoulda-matchers'
        gem 'ffaker'
      end

      # bundle install in the right directory!!
      # see https://github.com/rails/rails/issues/3153
      Bundler.with_clean_env do
        run 'bundle install'
      end
    end

    def setup_rspec
      generate 'rspec:install'
      # suppress warnings
      gsub_file '.rspec', "--warnings\n", ''
      remove_dir 'test'
    end

    def config_application
      # factories
      application do
        <<RUBY

    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.stylesheets false
    end
RUBY
      end
    end

    def db_migrations
      rake 'chaltron_engine:install:migrations'
    end

    def db_seed
      append_file 'db/seeds.rb' do
        <<RUBY
User.create do |u|
  u.username              = 'bella'
  u.fullname              = 'Bellatrix Lestrange'
  u.email                 = 'bellatrix.lestrange@azkaban.co.uk'
  u.password              = 'password.1'
  u.password_confirmation = 'password.1'
  u.roles                 = Chaltron.roles
end
RUBY
      end
    end

    def apply_layout
      # html
      remove_file 'app/views/layouts/application.html.erb'
      directory 'app/views/layouts'
      # javascript
      file = 'app/assets/javascripts/application.js'
      %w( nprogress nprogress-turbolinks chaltron ).each do |x|
        txt = "//= require #{x}\n"
        inject_into_file file, txt, before: '//= require_tree .'
      end
      # css
      file = 'app/assets/stylesheets/application.css'
      %w( nprogress nprogress-bootstrap font-awesome chaltron ).each do |x|
        txt = " *= require #{x}\n"
        inject_into_file file, txt, before: ' *= require_self'
      end
    end

    def create_index_controller
      generate 'controller home index'
      route "root to: 'home#index'"

      # controller, views and assets replacement
      copy_file 'app/controllers/home_controller.rb', force: true
      directory 'app/views/home/', force: true
      copy_file 'app/assets/javascripts/home.js.coffee', force: true
      copy_file 'app/assets/stylesheets/home.scss', force: true

      Array(1..10).each do |x|
        route "get 'home/test#{x}'"
      end
    end

    def setup_navigation
      copy_file 'config/navigation.rb'
    end

    def setup_chaltron
      copy_file 'config/initializers/chaltron.rb'
    end

    def setup_authorization
      copy_file 'app/models/ability.rb'
    end

    private

    def print_banner
      banner = Chaltron::Banner.new
    message = <<-TXT

    Be proud! You are running

#{set_color(banner.sample, :blue, true)}
    aka #{set_color('Muffaster reloaded', :red)}

    TXT
      say message
      print_welcome
    end

    def print_welcome
      message = 'Welcome to ' +
      set_color('L', :blue, true) +
      'igth ' +
      set_color('S', :blue, true) +
      'peed ' +
      set_color('A', :blue, true) +
      'pplication ' +
      set_color('D', :blue, true) +
      'evelopment!'
      say message
    end
  end
end
