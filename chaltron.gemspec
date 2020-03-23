$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'chaltron/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'chaltron'
  spec.version     = Chaltron::VERSION
  spec.authors     = ['vicvega']
  spec.email       = ['francesco.codazabetta@gmail.com']
  spec.homepage    = 'https://github.com/vicvega/chaltron'
  spec.summary     = 'An easy generator for rails applications.'
  spec.description = 'A ready-to-go application with authentication, authorization, logging... with bootstrap flavor.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 6.0.0'
  spec.add_dependency 'simple-navigation'
  spec.add_dependency 'bootstrap_form'
  spec.add_dependency 'autoprefixer-rails'

  spec.add_dependency 'devise'
  spec.add_dependency 'omniauth'
  spec.add_dependency 'omniauth-rails_csrf_protection'
  spec.add_dependency 'gitlab_omniauth-ldap'
  spec.add_dependency 'cancancan'

  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'factory_bot_rails'
end
