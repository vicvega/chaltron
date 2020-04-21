## Upgrade existing application to chaltron v2

#### 1 Upgrade to the last v1 version and ensure it's all working
You should re-run `rails generator chaltron:install` to keep all updated.

Sometimes it's easier to manually follow the [generator](https://github.com/vicvega/chaltron/blob/master/lib/generators/chaltron/install_generator.rb), to update what is needed. Don't forget to add the last [migration](https://github.com/vicvega/chaltron/blob/master/db/migrate/20200414150601_add_enabled_to_users.rb)!
```ruby
class AddEnabledToUsers < ActiveRecord::Migration[5.2]
  def change
      add_column :users, :enabled, :boolean, default: true
  end
end
```

#### 2 Install chalton v2
Just update your bundle

##### 2.1 Update `Gemfile`
Add the following gems
```
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
```

##### 2.2 Update `app/assets/javascripts/application.js`
Add the following dependencies, replacing `//= require chaltron`

```
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
```

And (at the bottom)

```javascript
document.addEventListener('DOMContentLoaded', function(event) {
  Chaltron.locale = $('body').data('locale');
});

NProgress.configure({
  showSpinner: false,
});
```

##### 2.3 Update stylesheets

Copy [chaltron_custom.scss](https://github.com/vicvega/chaltron/blob/master/lib/generators/chaltron/templates/app/assets/stylesheets/chaltron_custom.scss) and [datatables.scss](https://github.com/vicvega/chaltron/blob/master/lib/generators/chaltron/templates/app/assets/stylesheets/datatables.scss) into `app/assets/stylesheets/`

##### 2.4 Fix localization

In `app/views/layouts/application.html.erb` add the following data field to your `body`

```
<%= content_tag :body, data: { locale: I18n.locale } do %>
...
<% end %>
```


##### 2.5 Fix javascript

Remove `app/assets/javascripts/localization.js` (or any other reference to `Chaltron.prototype.lang`)

The current language is now retrieved with
```javascript
Chaltron.locale
```

Remove any reference to `Chaltron.locales`

`DataTables` objects are localized with the following options
```javascript
language: Chaltron.translate('datatable')
```
