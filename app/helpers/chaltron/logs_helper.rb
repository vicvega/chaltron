module Chaltron::LogsHelper
  def bootstrap_severity(severity)
    case severity.to_s
    when 'emerg', 'alert', 'crit', 'err'
      'danger'
    when 'warning', 'notice'
      'warning'
    when 'debug'
      'info'
    else
      'primary'
    end
  end
end
