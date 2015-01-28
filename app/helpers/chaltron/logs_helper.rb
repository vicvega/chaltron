module Chaltron::LogsHelper
  def display_panel(log, &block)
    klass = 'panel panel-'
    klass += case log.severity.to_sym
      when :info  then 'primary'
      when :error then 'danger'
      when :debug then 'info'
      else 'default'
    end
    content_tag :div, capture(&block), class: klass
  end
end
