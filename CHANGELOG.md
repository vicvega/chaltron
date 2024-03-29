**The latest chaltron release (1.x) targets bootstrap v4.**

If you are using bootstrap v3, refer to version 0, on [bootstrap3 branch](https://github.com/vicvega/chaltron/blob/bootstrap3/CHANGELOG.md).

### 2.0.4 - current version - unreleased
* use update instead of update_attributes (removed in Rails 6.1)
* fix role update at login based on LDAP groups
* gem update

### 2.0.3 - 20201-07-22
* gem update
* setup github workflow for CI
* fix legacy bootstrap classes

### 2.0.2 - 2021-07-20
* set bootstrap to version 4
* gem update

### 2.0.1 - 2020-06-17
* fix issue with install generator when database password is needed
* gem update

### 2.0.0 - 2020-05-25
* refactor all assets dependencies
* replace coffescript with javascript

### 1.1.7 - 2020-04-15
* add enable/disable user feature
* use warden callbacks for login/logout events
* gem update

### 1.1.6 - 2019-09-05
* make inline option programmable for role selection
* gem update

### 1.1.5 - 2019-05-27
* fix navbar backup and restore with turbolinks (all handled by javascript)

### 1.1.4 - 2019-05-27
* fix issue with SSL params for LDAP connection

### 1.1.3 - 2019-05-21
* fix issue with navbar and turbolinks
* gem update

### 1.1.2 - 2019-04-09
* add revision_filename parameter

### 1.1.1 - 2019-04-01
* display roles in users index view
* fix typo in en locale file
* update gem dependencies

### 1.1.0 - 2019-03-29
* fix LDAP access with authentication
* add LDAP fields name mapping
* add LDAP groups roles mapping
* add LDAP callback (after authenticate and before logout)

### 1.0.10 - 2019-03-15
* fix missing semicolons in view helpers
* fix Travis CI tests

### 1.0.9 - 2018-12-11
* Only local users can change their own email addresses
* update gem dependencies

### 1.0.8 - 2018-09-27
* fix breaking changes with ajax-datatables 1.0.0

### 1.0.7 - 2018-09-27
 * fix undefined method `def_delegators` issue
 * update gem dependencies

### 1.0.6 - 2018-08-27
 * avoid using Enumerable#sum to fix issue with empty array in ruby 2.5
 * use bootstrap_form_with in scaffold template, according to new rails scaffold
 * fix index view wideness in scaffold template
 * update gem dependencies

### 1.0.5 - 2018-07-09
 * fix logs index view wideness
 * fix indentation in scaffold template
 * update gem dependencies

### 1.0.4 - 2018-03-23
 * add missing translation for `Log` severities
 * fix all icons in scaffold template views
 * update gem dependencies

### 1.0.3 - 2018-03-12
 * fix missing icon in self edit view
 * extend `Log` severities to include standard syslog's
 * update gem dependencies

### 1.0.2 - 2018-02-09
 * use Font Awesome 5
 * update gem dependencies

### 1.0.1 - 2018-02-01
 * redesign default home page
 * fix alignment issue in navbar right menu

### 1.0.0 - 2018-01-22
 * compatibility with version 4 of bootstrap

Please check [bootstrap3 branch](https://github.com/vicvega/chaltron/blob/bootstrap3/CHANGELOG.md) for previous changes.
