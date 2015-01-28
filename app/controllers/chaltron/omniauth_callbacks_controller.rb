require 'chaltron/ldap/user'

module Chaltron
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  default_log_category I18n.t('chaltron.logs.category.login')

    def ldap
#      puts '##########################################'
#      puts oauth.inspect
#      puts '##########################################'
      # We only find ourselves here
      # if the authentication to LDAP was successful.
      user = Chaltron::LDAP::User.find_or_create(oauth, Chaltron.ldap_allow_all)
      if user.nil?
        redirect_to root_url, alert: I18n.t('chaltron.not_allowed_to_sign_in')
      else
        user.remember_me = true if user.persisted?
        flash[:notice] = I18n.t('devise.sessions.signed_in')

        info I18n.t('chaltron.logs.login_via', user: user.display_name, provider: 'ldap')
        sign_in_and_redirect(user)
      end
    end

    private

    def oauth
      @oauth ||= request.env['omniauth.auth']
    end
  end
end
