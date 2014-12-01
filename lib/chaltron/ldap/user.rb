# LDAP extension for User ::User
#
# * Find or create user from omniauth.auth data
# * Create user from uid
#
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
          if user.nil?
            # Look for user with same emails
            #
            # Possible cases:
            # * When user already has account and need to link their LDAP account.
            # * LDAP uid changed for user with same email and we need to update their uid
            #
            user = ::User.find_by(email: email)
            user.update_attributes(extern_uid: uid, provider: provider) unless user.nil?
          end
          if user.nil? and create
            # Create user
            password = Devise.friendly_token[0, 8].downcase
            opts = {
              extern_uid: uid,
              provider: provider,
              fullname: name,
              username: username,
              email: email,
              password: password,
              password_confirmation: password
            }
            user = ::User.build_user(opts)
            user.save!
          end
          # UPDATE PARAMETERS (department)
          user
        end

        def create(login)

        end

        private

        def find_by_uid_and_provider
          find_by_uid(uid)
        end

        def find_by_uid(uid)
          # LDAP distinguished name is case-insensitive
          ::User.where('provider = ? and lower(extern_uid) = ?', provider, uid.downcase).last
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
