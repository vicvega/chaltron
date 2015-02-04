class Chaltron::LogsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html

  def index
    @logs = @logs.accessible_by(current_ability)
  end

  def show
  end

end
