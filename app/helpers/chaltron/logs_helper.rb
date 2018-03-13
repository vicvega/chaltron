module Chaltron::LogsHelper
  def display_panel(log, &block)
    klass = "panel panel-#{bootstrap_severity(log.severity)}"
    content_tag :div, capture(&block), class: klass
  end

  def bootstrap_severity(severity)
    case severity.to_s
    when 'emerg', 'alert', 'crit', 'err'
      'danger'
    when 'warning'
      'warning'
    when 'debug'
      'info'
    else
      'primary'
    end
  end
end
