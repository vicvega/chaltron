SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    navigation.renderer = SimpleNavigationBootstrap::Bootstrap3
    primary.dom_class = 'pull-right'

    if signed_in?
      primary.item :admin,
        { icon: 'fa fa-fw fa-cogs',
          text: I18n.t('chaltron.menu.admin')
        }, nil do |admin|
        admin.item :users,
          { icon: 'fa fa-fw fa-users',
            text: I18n.t('chaltron.menu.users')
          }, users_url, highlights_on: /\/(users|ldap)(?!\/self_(show|edit|update))/ if can?(:manage, User)
        admin.item :logs,
          { icon: 'fa fa-fw fa-book',
            text: I18n.t('chaltron.menu.logs')
          }, logs_url, highlights_on: /\/logs/ if can?(:read, Log)
      end if can?(:manage, User) or can?(:read, Log)
      primary.item :logged, current_user.display_name.html_safe, nil do |user|
        user.item :self_edit, { icon: 'fa fa-fw fa-user',
                  text: I18n.t('chaltron.menu.self_show') }, self_show_users_url,
                  highlights_on: /\/self_(show|edit|update)/

        user.item :logout, { icon: 'fa fa-fw fa-sign-out', text: 'Logout' },
                  destroy_user_session_url, method: :delete
      end
    else
      primary.item :login, { icon: 'fa fa-fw fa-sign-in', text: 'Login' }, new_user_session_url
    end
  end
end
