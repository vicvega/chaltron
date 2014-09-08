class Chaltron::UsersController < ApplicationController
  def index
    @users = User.all
  end
end
