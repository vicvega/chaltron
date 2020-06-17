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

    def add_gem_dependencies
      gem 'devise'
      gem 'omniauth'
      gem 'omniauth-rails_csrf_protection'
      gem 'gitlab_omniauth-ldap'
      gem 'cancancan'

      gem 'bootstrap'
      gem 'autoprefixer-rails'
      gem 'font-awesome-sass'

      gem 'jquery-rails'
      gem 'jquery-datatables'
      gem 'ajax-datatables-rails'

      gem 'bootstrap_form'
      gem 'nprogress-rails'
      gem 'simple-navigation'
      gem 'rails-i18n'
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
      directory 'app/assets/images'
    end

    def add_javascript
      dependencies =<<EOF
//= require jquery
//= require popper
//= require bootstrap
//= require datatables/jquery.dataTables
//= require datatables/dataTables.bootstrap4
//= require datatables/extensions/Responsive/dataTables.responsive
//= require datatables/extensions/Responsive/responsive.bootstrap4
//= require nprogress
//= require nprogress-turbolinks
//= require nprogress-ajax
//= require chaltron
EOF

      inject_into_file 'app/assets/javascripts/application.js', dependencies, before: '//= require_tree .'

      javascript =<<JS


document.addEventListener('DOMContentLoaded', function(event) {
  Chaltron.locale = $('body').data('locale');
});

NProgress.configure({
  showSpinner: false,
});

JS
      inject_into_file 'app/assets/javascripts/application.js', javascript, after: '//= require_tree .'
    end

    def add_stylesheets
      copy_file 'app/assets/stylesheets/chaltron_custom.scss'
      copy_file 'app/assets/stylesheets/datatables.scss'
    end

    def create_index_controller
      generate 'controller home index'
      route "root to: 'home#index'"

      # controller, views and assets replacement
      copy_file 'app/controllers/home_controller.rb', force: true
      directory 'app/views/home/', force: true
      copy_file 'app/assets/javascripts/home.coffee', force: true
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

    def setup_ajax_datatables
      copy_file 'config/initializers/ajax_datatables_rails.rb'
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
