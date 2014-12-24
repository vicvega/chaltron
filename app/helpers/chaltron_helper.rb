module ChaltronHelper

  def ldap_enabled?
    Devise.omniauth_providers.include? :ldap
  end

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

  def back_link
    link_to :back, class: 'btn btn-primary' do
      icon('arrow-left') + '&nbsp;'.html_safe + t('chaltron.common.back')
    end
  end
end
