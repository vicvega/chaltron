require 'chaltron/banner'

class Chaltron::InstallGenerator < Rails::Generators::Base
  desc 'Install a chaltron skeleton application'
  source_root File.expand_path('templates', __dir__)

  class_option :interactive, type: :boolean, desc: 'Run interactive configuration.', default: true

  def disclaimer
    print_banner
    if options.interactive?
     exit unless yes?('Are you sure you want to continue? [yes/NO]')
    end
  end

  def add_foreman
    gem 'foreman'
    copy_file 'Procfile'
  end

  def add_javascript
    run 'yarn add bootstrap jquery popper.js @fortawesome/fontawesome-free ' \
        'datatables.net datatables.net-bs4'

    content = <<-JS
const webpack = require('webpack');
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
);
 JS

    insert_into_file 'config/webpack/environment.js', content + "\n",
      before: "module.exports = environment"

    directory 'app/javascript/packs', force: true
    directory 'app/javascript/stylesheets', force: true
    directory 'app/javascript/images', force: true

    directory 'app/assets/javascripts/', force: true
    insert_into_file 'app/assets/config/manifest.js', '//= link application.js'
  end

  def apply_layout
    directory 'app/views/layouts', force: true
  end

  def create_index_controller
    # controller, views and assets replacement
    copy_file 'app/controllers/home_controller.rb'
    directory 'app/views/home/'

    copy_file 'app/assets/stylesheets/home.scss'

    route "root to: 'home#index'"
    Array(1..10).each do |x|
      route "get 'home/test#{x}'"
    end
  end

  def add_navigation
    copy_file 'config/navigation.rb'
  end

  def add_bootstrap_form
    inject_into_file 'app/assets/stylesheets/application.css',
        " *= require rails_bootstrap_forms\n", before: ' *= require_tree .'
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
