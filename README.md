# Chaltron

[![Gem Version](https://badge.fury.io/rb/chaltron.svg)](http://badge.fury.io/rb/chaltron)
[![Actions Status: test](https://github.com/vicvega/chaltron/workflows/CI/badge.svg)](https://github.com/vicvega/chaltron/workflows/CI/badge.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/vicvega/chaltron/badge.svg?branch=master)](https://coveralls.io/github/vicvega/chaltron?branch=master)
[![Code Climate](https://codeclimate.com/github/vicvega/chaltron/badges/gpa.svg)](https://codeclimate.com/github/vicvega/chaltron)
[![security](https://hakiri.io/github/vicvega/chaltron/master.svg)](https://hakiri.io/github/vicvega/chaltron/master)

## Important note

**The latest chaltron release (1.x) targets bootstrap v4.**

If you are using bootstrap v3, refer to the  [bootstrap3](https://github.com/vicvega/chaltron/tree/bootstrap3) branch (chaltron version 0.x).

## Usage

In a fresh new rails application simply add to your `Gemfile`
```ruby
gem 'chaltron'
```
and install
```
bundle
```
Now run
```
rails generate chaltron:install
```

Populate database
```
rails db:migrate db:seed
```

Start your app
```
rails server
```

Login with local user `bella` and `password.1`

Enjoy!

## Features

Chaltron provides
 * local user (creation, authentication, forgotten password management...)
 * LDAP user (search, creation, authentication)
 * authorization (roles and permissions)
 * utility for log messages (syslog enabled)

Chaltron is powered by

 * [devise](https://github.com/plataformatec/devise/)
 * [cancancan](https://github.com/CanCanCommunity/cancancan/)
 * [bootstrap](https://github.com/twbs/bootstrap-rubygem)
 * [font-awesome](https://github.com/FortAwesome/font-awesome-sass)
 * [datatables](https://github.com/mkhairi/jquery-datatables)

Refer to [wiki pages](https://github.com/vicvega/chaltron/wiki) for further instructions

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
