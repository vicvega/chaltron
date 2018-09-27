class Chaltron::LogsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :html, :json

  def index
    respond_to do |format|
      format.html
      format.json { render json: LogDatatable.new(params, view_context: view_context) }
    end
  end

  def show
  end

end
