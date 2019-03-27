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
          if user.nil? and create
            groups = Chaltron.default_roles
            groups = Chaltron::LDAP::Person.find_groups_by_member(entry.dn).map do |e|
              Chaltron.ldap_role_mappings[e.dn]
            end if !Chaltron.ldap_role_mappings.blank?
            # create user
            user = entry.create_user(groups)
          end
          update_ldap_attributes(user, entry) unless user.nil?
          user
        end

        private

        def update_ldap_attributes(user, entry)
          user.update_attributes!(
            email: entry.email,
            department: entry.department
          )
        end

        def find_by_uid_and_provider
          # LDAP distinguished name is case-insensitive
          user = ::User.where('provider = ? and lower(extern_uid) = ?', provider, uid.downcase).last
          if user.nil?
            # Look for user with same emails
            #
            # Possible cases:
            # * When user already has account and need to link their LDAP account.
            # * LDAP uid changed for user with same email and we need to update their uid
            #
            user = ::User.find_by(email: email)
            user.update_attributes!(extern_uid: uid, provider: provider) unless user.nil?
          end
          user
        end

        def uid
          auth.info.uid || auth.uid
        end

        def email
          auth.info.email.downcase unless auth.info.email.nil?
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
          fail OmniAuth::Error, '(LDAP) ' + message
        end
      end
    end
  end
end
