module Chaltron::UsersHelper
  def display_username(user)
    if user == current_user
      link_to(user.username, user) + '&nbsp'.html_safe +
        content_tag(:span, I18n.t('chaltron.users.it_s_you'), class: 'badge badge-success')
    else
      link_to user.username, user
    end
  end

  def display_side_filter_link(url, active, text, count)

    klass = 'list-group-item list-group-item-action'
    klass += ' active' if active

    badge_klass = 'badge badge-pill float-right'
    if active
      badge_klass += ' badge-light'
    else
      badge_klass += ' badge-primary'
    end

    link_to url, class: klass do
      content_tag(:span, count, class: badge_klass) + text
    end

  end
end
