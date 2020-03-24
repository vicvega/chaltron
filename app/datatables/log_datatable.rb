class LogDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable
  attr_reader :view

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def_delegators :@view, :link_to, :content_tag, :bootstrap_severity, :current_ability

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      severity: { source: 'Log.severity',   searchable: false },
      date:     { source: 'Log.created_at', searchable: false },
      message:  { source: 'Log.message' },
      category: { source: 'Log.category',   searchable: false }
    }
  end

  private

  def data
    records.map do |log|
      {
        severity: content_tag(:span, I18n.t("chaltron.logs.severity.#{log.severity}"),
        class:    "badge badge-#{bootstrap_severity(log.severity)}"),
        date:     I18n.l(log.created_at, format: :short),
        message:  link_to(log.message, log),
        category: I18n.t("chaltron.logs.category.#{log.category}")
      }
    end
  end

  def get_raw_records
    # insert query here
    Log.accessible_by(current_ability)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
