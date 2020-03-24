require 'net/ldap'
require 'chaltron/ldap/person'

module Chaltron
  module LDAP
    class Connection
      NET_LDAP_ENCRYPTION_METHOD = {
        simple_tls: :simple_tls,
        start_tls: :start_tls,
        plain: nil
      }.freeze

      attr_reader :ldap

      def initialize
        @ldap = Net::LDAP.new(adapter_options)
      end

      def auth(login, password)
        filter = Net::LDAP::Filter.eq(uid, login)
        ldap.bind_as(base: base, filter: filter, password: password)
      end

      def find_by_uid(id)
        opts = {}
        opts[uid.to_sym] = id
        find_user(opts)
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
        return [] if args.empty?

        limit = args.delete(:limit)
        fields = args.keys

        if fields.include?(:dn)
          options = {
            base: args[:dn],
            scope: Net::LDAP::SearchScope_BaseObject
          }
        else
          filters = fields.map do |field|
            f = translate_field(field)
            Net::LDAP::Filter.eq(f, args[field]) if f
          end
          options = {
            base: base,
            filter: filters.inject { |sum, n| Net::LDAP::Filter.join(sum, n) }
          }
        end
        options.merge!(size: limit) unless limit.nil?
        ldap_search(options).map do |entry|
          Chaltron::LDAP::Person.new(entry, uid) if entry.respond_to? uid
        end.compact
      end

      def find_groups_by_member(entry)
        options = {
          base: Chaltron.ldap_group_base || base,
          filter: Chaltron.ldap_group_member_filter.call(entry)
        }
        ldap_search(options)
      end

      def update_attributes(distinguished_name, args)
        ldap.modify dn: distinguished_name,
                    operations: args.map { |k, v| [:replace, k, v] }
      end

      private

      def options
        Devise.omniauth_configs[:ldap].options
      end

      def translate_field(field)
        return uid if field.to_sym == :uid
        unless Chaltron.ldap_field_mappings[field.to_sym].nil?
          return Chaltron.ldap_field_mappings[field.to_sym]
        end

        field
      end

      def adapter_options
        opts = {
          host: options[:host],
          port: options[:port],
          encryption: encryption_options,
          verbose: true
        }
        opts.merge!(auth_options) if auth?
        opts
      end

      def base
        options[:base]
      end

      def uid
        options[:uid]
      end

      def encryption_options
        method = translate_method
        return unless method

        {
          method: method,
          tls_options: tls_options
        }
      end

      def translate_method
        NET_LDAP_ENCRYPTION_METHOD[options[:encryption]&.to_sym]
      end

      def tls_options
        return @tls_options if defined?(@tls_options)

        method = translate_method
        return unless method

        opts = if options[:disable_verify_certificates]
                 # It is important to explicitly set verify_mode for two reasons:
                 # 1. The behavior of OpenSSL is undefined when verify_mode is not set.
                 # 2. The net-ldap gem implementation verifies the certificate hostname
                 #    unless verify_mode is set to VERIFY_NONE.
                 { verify_mode: OpenSSL::SSL::VERIFY_NONE }
               else
                 # Dup so we don't accidentally overwrite the constant
                 OpenSSL::SSL::SSLContext::DEFAULT_PARAMS.dup
               end
        opts.merge!(custom_tls_options)

        @tls_options = opts
      end

      def custom_tls_options
        return {} unless options['tls_options']

        # Dup so we don't overwrite the original value
        custom_options = options['tls_options'].dup.delete_if do |_, value|
          value.nil? || value.blank?
        end
        custom_options.symbolize_keys!

        if custom_options[:cert]
          begin
            custom_options[:cert] =
              OpenSSL::X509::Certificate.new(custom_options[:cert])
          rescue OpenSSL::X509::CertificateError => e
            Rails.logger.error "LDAP TLS Options 'cert' is "\
                               "invalid for provider #{provider}: #{e.message}"
          end
        end

        if custom_options[:key]
          begin
            custom_options[:key] = OpenSSL::PKey.read(custom_options[:key])
          rescue OpenSSL::PKey::PKeyError => e
            Rails.logger.error "LDAP TLS Options 'key' is invalid for"\
                               "provider #{provider}: #{e.message}"
          end
        end
        custom_options
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

      def auth?
        options[:password] || options[:bind_dn]
      end
    end
  end
end
