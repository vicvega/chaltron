require 'net/ldap'
require 'chaltron/ldap/person'

module Chaltron
  module LDAP
    class Connection
      attr_reader :ldap

      def initialize(params = {})
        @ldap = Net::LDAP.new(adapter_options)
      end

      def auth(login, password)
        filter = Net::LDAP::Filter.eq(uid, login)
        ldap.bind_as(base: base, filter: filter, password: password)
      end

      def find_by_uid(id)
        find_user(uid: id)
      end

      def find_user(*args)
        find_users(*args).first
      end

      def ldap_search(*args)
        results = ldap.search(*args)
        if results.nil?
          response = ldap.get_operation_result
          unless response.code.zero?
            Rails.logger.warn("LDAP search error: #{response.message}")
          end
          []
        else
          results
        end
      end

      def find_users(args)
        limit = args.delete(:limit)
        fields = args.keys

        if fields.include?(:dn)
          options = {
            base: args[:dn],
            scope: Net::LDAP::SearchScope_BaseObject
          }
        else
          filters = []
          fields.each do |field|
            filters << Net::LDAP::Filter.eq(field, args[field])
          end
          options = {
            base: base,
            filter: filters.inject{|sum, n| Net::LDAP::Filter.join(sum, n)}
          }
        end

#        if config.user_filter.present?
#          user_filter = Net::LDAP::Filter.construct(config.user_filter)

#          options[:filter] = if options[:filter]
#                               Net::LDAP::Filter.join(options[:filter], user_filter)
#                             else
#                               user_filter
#                             end
#        end


        options.merge!(size: limit) if limit.present?

        entries = ldap_search(options).select do |entry|
          entry.respond_to? uid
        end

        entries.map do |entry|
          Chaltron::LDAP::Person.new(entry, uid)
        end

      end

      private

      def options
        Devise.omniauth_configs[:ldap].options
      end

      def adapter_options
        {
          host: options[:host],
          port: options[:port],
          encryption: encryption,
          verbose: true
        }.tap do |options|
          options.merge!(auth_options) if has_auth?
        end
      end

      def base
        options[:base]
      end

      def uid
        options[:uid]
      end

      def encryption
        case options[:method].to_s
        when 'ssl'
          :simple_tls
        when 'tls'
          :start_tls
        else
          nil
        end
      end

      def auth_options
        {
          auth: {
            method: :simple,
            username: options[:bind_dn],
            password: options[:password]
          }
        }
      end

      def has_auth?
        options[:password] || options[:bind_dn]
      end
    end
  end
end
