SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'justify-content-end'
    navigation.selected_class = 'active'

    if signed_in?
      primary.item :admin, I18n.t('chaltron.menu.admin'), '#', link_html: { icon: 'cogs' } do |admin|
        admin.item :users, I18n.t('chaltron.menu.users'), users_path, link_html: { icon: 'users' },
           highlights_on: /\/(users|ldap)(?!\/self_(show|edit|update))/ if can?(:manage, User)
        admin.item :logs, I18n.t('chaltron.menu.logs'), logs_path, link_html: { icon: 'book' },
           highlights_on: /\/logs/ if can?(:read, Log)
      end if can?(:manage, User) or can?(:read, Log)
      primary.item :logged, current_user.display_name.html_safe, '#',
        html: { class: 'dropdown-menu-right' } do |user|
        user.item :self_edit, I18n.t('chaltron.menu.self_show'), self_show_users_path,
          link_html: { icon: 'user' },
          highlights_on: /\/self_(show|edit|update)/
        user.item :logout, 'Logout', destroy_user_session_path, method: :delete,
          link_html: { icon: 'sign-out-alt' }
      end
    else
      primary.item :login, 'Login', new_user_session_path, link_html: { icon: 'sign-in-alt' }
    end
  end
end
