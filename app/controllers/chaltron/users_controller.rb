class Chaltron::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:self_show, :self_edit, :self_update]

  respond_to :html
  default_log_category :user_admin

  def index
    @filters = params[:filters] || {}

    # apply provider filter
    @users = @users.where(provider: nil) if @filters[:provider] == 'local'
    @users = @users.where(provider: :ldap) if @filters[:provider] == 'ldap'
    # apply activity filter
    @users = @users.where(sign_in_count: 0) if @filters[:activity] == 'no_login'
  end

  def show
  end

  def new
  end

  def edit
  end

  def self_show
  end

  def self_edit
  end

  def create
    if @user.save
      flash[:notice] = I18n.t('chaltron.users.created')
      info I18n.t('chaltron.logs.users.created',
        current: current_user.display_name, user: @user.display_name)
    end
    respond_with(@user)
  end

  def update
    flash[:notice] = I18n.t('chaltron.users.updated') if @user.update(update_params)
    respond_with(@user)
  end

  def self_update
    user_params_with_pass = self_update_params.dup
    if params[:user][:password].present?
      user_params_with_pass.merge!(
        password: params[:user][:password],
        password_confirmation: params[:user][:password_confirmation],
      )
    end
    if current_user.update(user_params_with_pass)
      flash[:notice] = I18n.t('chaltron.users.self_updated')
      render :self_show
    else
      render :self_edit
    end
  end

  def destroy
    if current_user == @user
      redirect_to({ action: :index }, alert: I18n.t('chaltron.users.cannot_self_destroy'))
    else
      info I18n.t('chaltron.logs.users.destroyed',
        current: current_user.display_name, user: @user.display_name)
      @user.destroy
      respond_with(@user)
    end
  end

  private
  def create_params
    params.require(:user).permit(:username, :email, :fullname,
      :password, :password_confirmation, roles: [])
  end

  def update_params
    params.require(:user).permit(roles: [])
  end

  def self_update_params
    params.require(:user).permit(:email, :fullname)
  end

end
