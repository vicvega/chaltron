class Chaltron::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

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
end
