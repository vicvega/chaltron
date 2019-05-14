### 0.3.1 - current version - unreleased
* gem update

### 0.3.0 - 2019-04-01
* fix LDAP access with authentication
* add LDAP fields name mapping
* add LDAP groups roles mapping
* add LDAP callback (after authenticate and before logout)

### 0.2.11 - 2019-03-15
* fix Travis CI tests
* fix missing semicolons in view helpers

### 0.2.10 - 2018-12-11
 * Only local users can change their own email addresses
 * fix tests

### 0.2.9 - 2018-08-27
 * avoid using Enumerable#sum to fix issue with empty array in ruby 2.5

### 0.2.8 - 2018-03-13
 * fix font-awesome-sass version number (must be < 5)

### 0.2.7 - 2018-03-13
 * extend Log severities to include standard syslog's

### 0.2.6 - 2018-01-26
 * fix new_user button disappearing on small screens

### 0.2.5 - 2018-01-22
* FactoryBot replaces FactoryGirl
* wrap table in `div.table-responsive` to improve mobile layout
* remove dependency from moment.js
* update gem dependencies

### 0.2.4 - 2017-10-19
 * fix duplicated javascript inclusion
 * update gem dependencies

### 0.2.3 - 2017-10-03
 * fix flash messages fade out trigger with turbolinks
 * use `_path` instead of `_url` in route helpers
 * update gem dependencies

### 0.2.2 - 2017-08-22
 * fix scaffold template for boolean type
 * fix right drop-down menu alignment
 * minor fix in default views
 * update gem dependencies

### 0.2.1 - 2017-06-29
 * update gem dependencies
 * fix duplicate datatables wrappers with browser back button
 * minor fix in default views

### 0.2.0 - 2017-06-20
* restore jquery-datatables-rails gem dependency
* update gem dependencies (**rails 5.1 required**)

### 0.1.6 - 2017-01-17
 * fix scaffold template, removing deprecated helpers
 * update gem dependencies

### 0.1.5 - 2016-07-14
 * rails 5 compatibility
 * update gem dependencies

### 0.1.4 - 2016-03-31
 * fix highlighting in admin menu
 * remove images (all default images are copied to application by generator task)
 * update gem dependencies

### 0.1.3 - 2015-11-25
 * remove jquery-datatables-rails gem dependency
 * add footer to default layout
 * add display of revision number (if REVISION file present)

### 0.1.2 - 2015-07-22
 * add remember_me button for LDAP login
 * allow local login with either username or password

### 0.1.1 - 2015-05-15
 * remove test files from gem package
 * update gem dependencies

### 0.1.0 - 2015-03-04
 * first release
