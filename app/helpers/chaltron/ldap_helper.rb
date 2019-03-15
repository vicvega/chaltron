module Chaltron::LdapHelper

  def display_entry_name(entry)
    if User.exists?(username: entry.username)
      (entry.name + '&nbsp;').html_safe +
        tag_label(I18n.t('chaltron.users.already_present'), :danger)
    else
      entry.name
    end
  end

  def display_entry_email(entry)
    mail = entry.email
    if mail.blank?
      tag_label(I18n.t('chaltron.users.missing_field'), :danger)
    else
      mail
    end
  end

end
