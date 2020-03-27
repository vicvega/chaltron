Chaltron.setup do |config|
  config.ldap_allow_all = false

  config.ldap_field_mappings = {
    first_name: 'givenName',
    last_name: 'sn',
    email: 'mail',
    full_name: 'cn'
  }
end
