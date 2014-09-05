module ChaltronHelper
  #
  # Flash messages
  #
  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error:   'alert-danger',
      alert:   'alert-warning',
      notice:  'alert-info'
    }[flash_type] || flash_type.to_s
  end

  def flash_message(message, type)
    content_tag(:div, message, class: "alert #{bootstrap_class_for(type)} alert_link") do
      content_tag(:strong, I18n.t("chaltron.flash.#{type}").capitalize + ': ') +
      message
    end
  end
end
