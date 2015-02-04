module Chaltron::LogsHelper
  def display_panel(log, &block)
    klass = "panel panel-#{bootstrap_severity(log.severity)}"
    content_tag :div, capture(&block), class: klass
  end

  def display_message(log)
    link_to(log.message, log) + '&nbsp'.html_safe +
    tag_label(I18n.t("chaltron.logs.severity.#{log.severity}"), bootstrap_severity(log.severity))
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
