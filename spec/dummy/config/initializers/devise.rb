Devise.setup do |config|
  config.omniauth :ldap,
      host:     ENV.fetch('LDAP_HOST', '127.0.0.1'),
      base:     'dc=azkaban,dc=co,dc=uk',
      uid:      'uid',
      port:     389,
      encryption:   :plain,
      bind_dn:  'cn=admin,dc=azkaban,dc=co,dc=uk',
      password: 'admin'
      # filter: '(&(uid=%{username})(memberOf=cn=myapp-users,ou=groups,dc=example,dc=com))'
end
