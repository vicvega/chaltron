class Chaltron::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    # apply provider filter
    @users = @users.where(provider: nil) if params[:provider] == 'local'
    @users = @users.where(provider: :ldap) if params[:provider] == 'ldap'
    # apply activity filter
    @users = @users.where(sign_in_count: 0) if params[:activity] == 'no_login'
  end
end
