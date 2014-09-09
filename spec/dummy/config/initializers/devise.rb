Devise.setup do |config|
  config.omniauth :ldap,
      host:     'localhost',
      base:     'dc=example,dc=com',
      uid:      'uid',
      port:     389,
      method:   :plain
      #filter: '(&(uid=%{username})(memberOf=cn=myapp-users,ou=groups,dc=example,dc=com))'
end
