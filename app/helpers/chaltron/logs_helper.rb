module Chaltron::LogsHelper
  def display_panel(log, &block)
    klass = "panel panel-#{bootstrap_severity(log.severity)}"
    content_tag :div, capture(&block), class: klass
  end

  def bootstrap_severity(severity)
    case severity.to_s
    when 'info'  then 'primary'
    when 'error' then 'danger'
    when 'debug' then 'info'
    else 'default'
    end
  end
end
