source "https://rubygems.org"

# Declare your gem's dependencies in chaltron.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'byebug', group: [:development, :test]
group :test do
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'turbolinks', '~> 5'
  gem 'coffee-rails', '~> 4.2'
end

gem 'rails-html-sanitizer', '~> 1.0', '>= 1.0.4'
