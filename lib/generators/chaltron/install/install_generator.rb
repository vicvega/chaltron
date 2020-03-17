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
