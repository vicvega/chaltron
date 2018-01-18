module Chaltron::LogsHelper
  def bootstrap_severity(severity)
    case severity.to_s
    when 'info'  then 'primary'
    when 'error' then 'danger'
    when 'debug' then 'info'
    else 'default'
    end
  end
end
