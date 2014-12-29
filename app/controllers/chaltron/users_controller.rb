class Chaltron::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
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

  def create
    @user = User.new(user_params)
    flash[:notice] = I18n.t('chaltron.users.created') if @user.save
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  def destroy
    @user.destroy
    respond_with(@user)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :fullname, :roles_mask,
      :password, :password_confirmation)
  end

end
