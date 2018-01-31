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

    def gemfile
      gem 'bootstrap_form',
        git: 'https://github.com/bootstrap-ruby/rails-bootstrap-forms.git',
        branch: 'master'
      Bundler.with_clean_env do
        run 'bundle install'
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
      directory 'app/assets/images'
      # javascript
      inject_into_file 'app/assets/javascripts/application.js',
        "//= require chaltron\n", before: '//= require_tree .'
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
      copy_file 'app/assets/stylesheets/chaltron_custom.scss'
    end

    def setup_authorization
      copy_file 'app/models/ability.rb'
    end

    def setup_ajax_datatables
      ajax_datatables_rails_file = 'config/initializers/ajax_datatables_rails.rb'
      copy_file ajax_datatables_rails_file

      # setup ajax-datatables-rails
      db_adapter =
        case ActiveRecord::Base.connection.adapter_name
        when 'Mysql2'     then :mysql2
        when 'SQLite'     then :sqlite3
        when 'PostgreSQL' then :pg
        else nil
        end

      if db_adapter.nil?
        message =<<EOF
  PAY ATTENTION!
  ajax-datatables-rails gem (needed by chaltron) does not support #{options[:database]}.
  See https://github.com/antillas21/ajax-datatables-rails#searching-on-non-text-based-columns.
  You may experience problems!
EOF
        say message
      else
        gsub_file ajax_datatables_rails_file,
          /# config.db_adapter = :mysql2/, "config.db_adapter = :#{db_adapter}"
      end

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
