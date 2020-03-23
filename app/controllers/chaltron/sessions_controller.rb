# require 'chaltron/ldap/connection'

class Chaltron::SessionsController  < Devise::SessionsController
  after_action :after_login, only: :create
  before_action :before_logout, only: :destroy

  # default_log_category :login

  def after_login
    #info I18n.t('chaltron.logs.login', user: current_user.display_name)
  end

  def before_logout
    # Chaltron.ldap_before_logout.call(current_user, Chaltron::LDAP::Connection.new) if current_user.ldap_user?
    # info I18n.t('chaltron.logs.logout', user: current_user.display_name)
  end
end
