SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    navigation.renderer = SimpleNavigationRenderers::Bootstrap3
    primary.dom_class = 'pull-right'

    if signed_in?
      primary.item :admin,
        { icon: 'fa fa-fw fa-cogs',
          text: I18n.t('chaltron.menu.admin').titleize
        }, nil do |admin|
        admin.item :users,
        { icon: 'fa fa-fw fa-users',
          text: I18n.t('chaltron.menu.users').titleize
        }, users_url
      end
      primary.item :logged, current_user.display_name.html_safe, nil do |user|
        user.item :logout, { icon: 'fa fa-fw fa-sign-out', text: 'Logout' },
                  destroy_user_session_url, method: :delete
      end
    else
      primary.item :login, { icon: 'fa fa-fw fa-sign-in', text: 'Login' }, new_user_session_url
    end
  end
end
