module Chaltron
  module LDAP
    class Person
      # Active Directory-specific LDAP filter that checks if bit 2 of the
      # userAccountControl attribute is set.
      # Source: http://ctogonewild.com/2009/09/03/bitmask-searches-in-ldap/
#      AD_USER_DISABLED = Net::LDAP::Filter.ex("userAccountControl:1.2.840.113556.1.4.803", "2")

      attr_accessor :entry

#      def self.find_by_uid(uid, adapter)

#        config.uid => @uid
#        adapter.user(adapter.config.uid, uid)


#      end

#      def self.find_by_dn(dn, adapter)
#        adapter.user('dn', dn)
#      end

#      def self.disabled_via_active_directory?(dn, adapter)
#        adapter.dn_matches_filter?(dn, AD_USER_DISABLED)
#      end

      def initialize(entry, uid)
      #  Rails.logger.debug { "Instantiating #{self.class.name} with LDIF:\n#{entry.to_ldif}" }
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

#      private

#      def entry
#        @entry
#      end
    end
  end
end
