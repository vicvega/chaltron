class Chaltron::SessionsController  < Devise::SessionsController
  after_filter :after_login, only: :create
  before_filter :before_logout, only: :destroy

  default_log_category :login

  def after_login
    info I18n.t('chaltron.logs.login', user: current_user.display_name)
  end

  def before_logout
    info I18n.t('chaltron.logs.logout', user: current_user.display_name)
  end
end
