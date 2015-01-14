#require 'chaltron/ldap/person'

class Chaltron::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:self_show, :self_edit, :self_update, :ldap_create, :ldap_search]
  #before_action :authorize_create_user, only: [:ldap_create, :ldap_search]

  respond_to :html

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
    flash[:notice] = I18n.t('chaltron.users.created') if @user.save
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
      @user.destroy
      respond_with(@user)
    end
  end

#  def ldap_search
#    @limit = default_limit
#  end

#  def ldap_new
#    @ldap_entries = []
#    userid     = params[:userid]
#    department = params[:department]
#    name       = params[:fullname]
#    limit      = params[:limit].to_i
#    if userid.present?
#      entry = Chaltron::LDAP::Person.find_by_uid(userid)
#      @ldap_entries << entry unless entry.nil?
#    else
#      opts = {}
#      opts[:department] = "*#{department}*" unless department.blank?
#      opts[:cn]         = "*#{name}*"       unless name.blank?
#      opts[:limit]      = limit.zero? ? default_limit : limit

#      res = Chaltron::LDAP::Person.find_by_fields(opts)
#      @ldap_entries = res
#    end
#  end

#  def ldap_create
#  end

  private
#  def default_limit
#    100
#  end

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

#  def authorize_create_user
#    authorize! :create, User
#  end
end
