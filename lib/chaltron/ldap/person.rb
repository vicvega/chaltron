require 'chaltron/ldap/connection'

module Chaltron
  module LDAP
    class Person
      attr_accessor :entry

      def self.valid_credentials?(login, password)
        ldap.auth(login, password)
      end

      def self.find_by_field(field, value)
        ldap.find_users(field.to_sym => value)
      end

      def self.find_by_fields(fields={})
        ldap.find_users(fields)
      end

      def self.find_by_uid(uid)
        ldap.find_by_uid(uid)
      end

      def initialize(entry, uid)
        #Rails.logger.debug { "Instantiating #{self.class.name} with LDIF:\n#{entry.to_ldif}" }
        @entry = entry
        @uid = uid
      end

      def create_user(roles = [])
        password = Devise.friendly_token[0, 8].downcase
        user = ::User.new(extern_uid: dn,
          provider: provider,
          fullname: name,
          username: username,
          email: email,
          password: password,
          password_confirmation: password,
          department: department
        )
        user.roles = roles
        user.save!
        user
      end

      def department
        entry.department.first rescue nil
      end

      def name
        entry.cn.first
      end

      def uid
        entry.send(@uid).first
      end

      def username
        uid
      end

      def email
        entry.mail.first rescue nil
      end

      def dn
        entry.dn
      end

      def provider
        'ldap'
      end

      private

      def self.ldap
        @connection ||= Chaltron::LDAP::Connection.new
      end

    end
  end
end
