Devise.setup do |config|
  config.omniauth :ldap,
      host:     'localhost',
      base:     'ou=people,dc=azkaban,dc=co,dc=uk',
      uid:      'uid',
      port:     389,
      method:   :plain,
      bind_dn:  'cn=admin,dc=azkaban,dc=co,dc=uk',
      password: 'admin'
      # filter: '(&(uid=%{username})(memberOf=cn=myapp-users,ou=groups,dc=example,dc=com))'
end
