module ChaltronHelper

  def ldap_enabled?
    Devise.omniauth_providers.include? :ldap
  end

  def icon(style, name, text = nil, html_options = {})
    if text.is_a?(Hash)
      html_options = text
      text = nil
    end
    content_class = "#{style} fa-#{name}"
    content_class << " #{html_options[:class]}" if html_options.key?(:class)
    html_options[:class] = content_class

    html = content_tag(:i, nil, html_options)
    html << ' ' << text.to_s unless text.blank?
    html
  end

  def back_link(opts = {})
    klass = opts[:class] || 'btn btn-primary'
    text  = opts[:text]  || t('chaltron.common.back')
    ic    = opts[:icon]  || 'arrow-left '

    link_to :back, class: klass do
      icon(:fas, ic, text)
    end
  end

  #
  # Flash messages
  #
  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[flash_type] || flash_type.to_s
  end

  def flash_message(message, type)
    content_tag(:div, message,
                class: "alert #{bootstrap_class_for(type)} rounded-0") do
      content_tag(:strong, I18n.t("chaltron.flash.#{type}") + ': ') +
        message
    end
  end

  #
  # Get current revision
  #
  def revision
    @revision || read_revision_number
  end

  private

  def read_revision_number
    version_file = "#{Rails.root}/REVISION"
    return unless File.exist?(version_file)

    v = IO.read(version_file).strip
    v.blank? ? nil : v
  end
end
