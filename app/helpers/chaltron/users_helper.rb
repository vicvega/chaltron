module Chaltron::UsersHelper
  def display_username(user)
    if user == current_user
      link_to(user.username, user) + '&nbsp'.html_safe +
        tag_label(I18n.t('chaltron.users.it_s_you'), :success)
    else
      link_to user.username, user
    end
  end
end
