Chaltron.setup do |config|
  # Add new roles to the right and NEVER change role order, or you'll break every role bitmask
  # config.roles = %w[ admin user_admin ]

  config.ldap_allow_all = false

  config.ldap_field_mappings = {
    first_name: 'givenName',
    last_name: 'sn',
    email: 'mail',
    full_name: 'cn'
  }
end
