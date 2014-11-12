class Chaltron::UsersController < ApplicationController
  def index
    @users = User.all
    # apply provider filter
    @users = @users.where(provider: nil) if params[:provider] == 'local'
    @users = @users.where(provider: :ldap) if params[:provider] == 'ldap'
    # apply activity filter
    @users = @users.where(sign_in_count: 0) if params[:activity] == 'no_login'
  end
end
