**The latest chaltron release (1.x) targets bootstrap v4.**

If you are using bootstrap v3, refer to version 0, on [bootstrap3 branch](https://github.com/vicvega/chaltron/blob/bootstrap3/CHANGELOG.md).

### 1.1.1 - current version - unreleased
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
