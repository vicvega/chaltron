module Chaltron::LdapHelper

  def display_entry_name(entry)
    if User.exists?(username: entry.username)
      (entry.name + '&nbsp').html_safe +
        content_tag(:span, I18n.t('chaltron.users.already_present'), class: 'badge badge-danger')
    else
      entry.name
    end
  end

  def display_entry_email(entry)
    mail = entry.email
    if mail.blank?
      content_tag(:span, I18n.t('chaltron.users.missing_field'), class: 'badge badge-danger')
    else
      mail
    end
  end

end
