require 'rails/generators'
require 'chaltron/banner'

module Chaltron
  # Install a skeleton application
  class InstallGenerator < Rails::Generators::Base
    desc "Install a chaltron skeleton application"
    source_root File.expand_path("../templates", __FILE__)
    class_option :interactive, type: :boolean, desc: "Run interactive configuration.", default: true

    def disclaimer
      @banner = Chaltron::Banner.new
      message = "\tBe proud! You are running\n" +
      set_color(@banner.sample, :blue, true) + "\n"
      say message

      message = "\taka " +
      set_color('Muffaster reloaded', :red)
      say message

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

      if options.interactive?
        exit unless yes?("Are you sure you want to continue? [yes/NO]")
      end
    end

    def install_gems
      gem 'rails-i18n'
      gem 'nprogress-rails'
      gem 'simple_form', git: 'https://github.com/plataformatec/simple_form.git'

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
      #suppress warnings
      gsub_file '.rspec', "--warnings\n", ''
      remove_dir 'test'
    end

    def setup_simple_form
      generate 'simple_form:install --bootstrap'
      gsub_file 'config/initializers/simple_form_bootstrap.rb', 'config.default_wrapper = :vertical_form', 'config.default_wrapper = :horizontal_form'
    end

    def config_application
      # factories
      application do<<-RUBY
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
      append_file 'db/seeds.rb' do<<-RUBY
User.create do |u|
  u.username              = 'draco'
  u.fullname              = 'Draco Malfoy'
  u.email                 = 'draco.malfoy@voldemort.com'
  u.password              = 'password.1'
  u.password_confirmation = 'password.1'
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
      %w[ nprogress nprogress-turbolinks chaltron ].each do |x|
        txt = "//= require #{x}\n"
        inject_into_file file, txt, before: '//= require_tree .'
      end
      # css
      file = "app/assets/stylesheets/application.css"
      %w[ nprogress nprogress-bootstrap font-awesome chaltron ].each do |x|
        txt = " *= require #{x}\n"
        inject_into_file file, txt, before: ' *= require_self'
      end
      append_file file do<<-RUBY

/* navbar */
div#content {
  margin-top: 40px;
}
        RUBY
      end
    end

    def create_index_controller
      generate 'controller home index'
      route "root to: 'home#index'"

      # controller, views and assets replacement
      copy_file 'app/controllers/home_controller.rb', force: true
      directory 'app/views/home/', force: true
      copy_file 'app/assets/javascripts/home.js.coffee', force: true
      copy_file 'app/assets/stylesheets/home.css.scss', force: true

      Array(1..10).each do |x|
        route "get 'home/test#{x}'"
      end
    end

    def copy_locale
      copy_file 'config/locales/simple_form.it.yml'
    end

    def setup_navigation
      copy_file 'config/navigation.rb'
    end

  end
end