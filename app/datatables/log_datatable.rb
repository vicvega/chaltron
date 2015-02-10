class LogDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :link_to, :tag_label, :bootstrap_severity, :current_ability

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w( Log.severity Log.created_at Log.message Log.category )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w( Log.message Log.category )
  end

  private

  def data
    records.map do |log|
      [
        tag_label(I18n.t("chaltron.logs.severity.#{log.severity}"), bootstrap_severity(log.severity)),
        I18n.l(log.created_at, format: :short),
        link_to(log.message, log),
        I18n.t("chaltron.logs.category.#{log.category}")
      ]
    end
  end

  def get_raw_records
    # insert query here
    Log.accessible_by(current_ability)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
