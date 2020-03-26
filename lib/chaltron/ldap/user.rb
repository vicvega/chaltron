# LDAP extension for User ::User
#
# * Find or create user from omniauth.auth data
#

require 'chaltron/ldap/person'

module Chaltron
  module LDAP
    class User
      class << self
        attr_reader :auth

        def find_or_create(auth, create)
          @auth = auth
          if uid.blank? || email.blank? || username.blank?
            raise_error('Account must provide a dn, uid and email address')
          end
          user = find_by_uid_and_provider
          entry = Chaltron::LDAP::Person.find_by_uid(username)
          if user.nil? && create
            # create user
            roles = Chaltron.default_roles
            unless Chaltron.ldap_role_mappings.blank?
              roles = entry.ldap_groups.map do |e|
                Chaltron.ldap_role_mappings[e.dn]
              end.compact
            end
            user = entry.create_user(roles: roles)
          end
          update_ldap_attributes(user, entry) unless user.nil?
          user
        end

        private

        def update_ldap_attributes(user, entry)
          user.update!(
            email: entry.email,
            department: entry.department
          )
        end

        def find_by_uid_and_provider
          # LDAP distinguished name is case-insensitive
          user = ::User.where('provider = ? and lower(extern_uid) = ?',
                              provider, uid.downcase).last
          if user.nil?
            # Look for user with same emails
            #
            # Possible cases:
            # * When user already has account and need to link their LDAP account.
            # * LDAP uid changed for user with same email and we need to update their uid
            #
            user = ::User.find_by(email: email)
            user&.update!(extern_uid: uid, provider: provider)
          end
          user
        end

        def uid
          auth.info.uid || auth.uid
        end

        def email
          auth.info.email&.downcase
        end

        def name
          auth.info.name.to_s.force_encoding('utf-8')
        end

        def username
          auth.info.nickname.to_s.force_encoding('utf-8')
        end

        def provider
          'ldap'
        end

        def raise_error(message)
          raise OmniAuth::Error, '(LDAP) ' + message
        end
      end
    end
  end
end
