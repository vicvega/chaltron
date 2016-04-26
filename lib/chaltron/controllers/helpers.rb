module Chaltron
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers
      extend ActiveSupport::Concern
      included do
        rescue_from ::CanCan::AccessDenied do |exception|
          alert = current_user.nil? ? t('chaltron.access_denied_try_login') : t('chaltron.access_denied')
          redirect_to root_url, alert: alert
        end
      end

      module ClassMethods
        def log_category
          defined?(@log_category) ? @log_category : self.to_s.downcase
        end

        def default_log_category(cat)
          @log_category = cat.to_s
        end
      end

      #
      # Utilities for logging
      #
      def info(message, category = nil)
        create_log_message(message, category, :info)
      end

      def debug(message, category = nil)
        create_log_message(message, category, :debug)
      end

      def error(message, category = nil)
        create_log_message(message, category, :error)
      end

      private
      def create_log_message(message, category, severity)
        category ||= self.class.log_category
        ::Log.create(
          message: message,
          category: category.to_s,
          severity: severity.to_s
        )
      end

      #
      # To allow login with username or email
      #
      protected
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in) do |user|
          user.permit(:login, :username, :email, :password, :remember_me)
        end
      end

    end
  end
end
