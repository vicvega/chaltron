require 'chaltron/ldap/connection'

module Chaltron
  module LDAP
    class Adapter

      def self.valid_credentials?(login, password)
        ldap.auth(login, password)
      end

      def self.find_by_field(field, value)
        ldap.user(field, value)
      end

      def self.find_by_uid(uid)
        ldap.find_by_uid(uid)
      end


      private

      def self.ldap
       @connection ||= Chaltron::LDAP::Connection.new
      end
    end
  end
end
