class Chaltron::LogsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:self_show, :self_edit, :self_update]

  respond_to :html

  def index
    @filters = params[:filters] || {}

    @logs = @logs.accessible_by(current_ability)
    # apply severity filter
    @logs = @logs.where(severity: @filters[:severity]) if @filters[:severity].present?
  end

  def show
  end

end
