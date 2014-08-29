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
  s.description = 'Unleash more fiammacula power to move faster and break things.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.1.0'
  s.add_dependency 'devise', '~> 3.2.3'
  s.add_dependency 'omniauth'
  s.add_dependency 'omniauth-ldap'
  s.add_dependency 'autoprefixer-rails'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'font-awesome-sass'
  s.add_dependency 'sass-rails'
  s.add_dependency 'nprogress-rails'
  s.add_dependency 'simple_form'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'ffaker'
end
