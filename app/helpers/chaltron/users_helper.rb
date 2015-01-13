module Chaltron::UsersHelper
  def display_username(user)
    if user == current_user
      link_to(user.username, user) + '&nbsp'.html_safe +
        tag_label(I18n.t('chaltron.users.it_s_you'), :success)
    else
      link_to user.username, user
    end
  end

  def display_ldap_entry_username(entry)
    if current_user.username == entry.username
      (entry.username + '&nbsp').html_safe +
        tag_label(I18n.t('chaltron.users.it_s_you'), :success)
    else
      entry.username
    end
  end

  def display_ldap_entry_email(entry)
    mail = entry.email
    if mail.blank?
      tag_label(I18n.t('chaltron.users.missing_field'), :danger)
    else
      mail
    end
  end

end
