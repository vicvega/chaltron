require 'chaltron/ldap/user'

module Chaltron
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def ldap
      #    puts '##########################################'
      #    puts oauth.inspect
      #    puts '##########################################'

      # We only find ourselves here
      # if the authentication to LDAP was successful.
      @user = Chaltron::LDAP::User.find_or_create(oauth)
      @user.remember_me = true if @user.persisted?

      flash[:notice] = I18n.t('devise.sessions.signed_in')
      sign_in_and_redirect(@user)
    end

    private

    def oauth
      @oauth ||= request.env['omniauth.auth']
    end
  end
end
