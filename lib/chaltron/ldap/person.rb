require 'chaltron/ldap/connection'

module Chaltron
  module LDAP
    class Person
      attr_accessor :entry

      def self.valid_credentials?(login, password)
        ldap.auth(login, password)
      end

      def self.find_by_field(field, value)
        ldap.users(field, value)
      end

      def self.find_by_uid(uid)
        ldap.find_by_uid(uid)
      end

      def initialize(entry, uid)
        Rails.logger.debug { "Instantiating #{self.class.name} with LDIF:\n#{entry.to_ldif}" }
        @entry = entry
        @uid = uid
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
        entry.try(:mail)
      end

      def dn
        entry.dn
      end

      private

      def self.ldap
        @connection ||= Chaltron::LDAP::Connection.new
      end

    end
  end
end
