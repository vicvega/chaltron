$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'chaltron/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'chaltron'
  s.version     = Chaltron::VERSION
  s.authors     = ['vicvega']
  s.email       = ['francesco.codazabetta@gmail.com']
  s.homepage    = 'https://github.com/vicvega/chaltron'
  s.summary     = 'Move faster and break things - revisited for rails 4'
  s.description = 'A ready-to-go application with authentication, authorization, logging... with bootstrap flavor'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.0'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'devise'
  s.add_dependency 'omniauth'
  s.add_dependency 'omniauth-rails_csrf_protection'
  s.add_dependency 'gitlab_omniauth-ldap'
  s.add_dependency 'autoprefixer-rails'
  s.add_dependency 'bootstrap'
  s.add_dependency 'font-awesome-sass'
  s.add_dependency 'nprogress-rails'
  s.add_dependency 'simple-navigation'
  s.add_dependency 'jquery-datatables'
  s.add_dependency 'ajax-datatables-rails'
  s.add_dependency 'cancancan'
  s.add_dependency 'bootstrap_form'
  s.add_dependency 'rails-i18n'
  s.add_dependency 'jquery-rails'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rails-controller-testing'

end
