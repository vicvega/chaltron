SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    navigation.renderer = SimpleNavigation::Renderer::Json
#    primary.dom_class = 'pull-right'

    if signed_in?
      primary.item :admin, { icon: 'cogs',  text: I18n.t('chaltron.menu.admin') }, nil do |admin|
        admin.item :users, { icon: 'users', text: I18n.t('chaltron.menu.users') },
          users_path, highlights_on: /\/(users|ldap)(?!\/self_(show|edit|update))/ if can?(:manage, User)
        admin.item :logs, { icon: 'book', text: I18n.t('chaltron.menu.logs') },
          logs_path, highlights_on: /\/logs/ if can?(:read, Log)
      end if can?(:manage, User) or can?(:read, Log)
      primary.item :logged, current_user.display_name.html_safe, nil do |user|
        user.dom_class = 'dropdown-menu-right'
        user.item :self_edit, { icon: 'user',
                  text: I18n.t('chaltron.menu.self_show') }, self_show_users_path,
                  highlights_on: /\/self_(show|edit|update)/
        user.item :logout, { icon: 'sign-out', text: 'Logout' },
                  destroy_user_session_path, method: :delete
      end
    else
      primary.item :login, { icon: 'sign-in', text: 'Login' }, new_user_session_path
    end
  end
end
