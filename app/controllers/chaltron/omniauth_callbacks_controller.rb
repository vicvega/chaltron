require 'chaltron/ldap/user'

module Chaltron
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

    default_log_category :login

    def ldap
#      puts '##########################################'
#      puts oauth.inspect
#      puts '##########################################'
      # We only find ourselves here
      # if the authentication to LDAP was successful.
      user = Chaltron::LDAP::User.find_or_create(oauth, Chaltron.ldap_allow_all)

      if user.nil?
        redirect_to new_user_session_url, alert: I18n.t('chaltron.not_allowed_to_sign_in')
      else
        user.remember_me = params[:remember_me] if user.persisted?
        sign_in_and_redirect(user, event: :authentication)
        set_flash_message(:notice, :success, kind: 'LDAP')
      end
    end

    private

    def oauth
      @oauth ||= request.env['omniauth.auth']
    end
  end
end
