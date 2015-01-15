module LoginHelpers
  # Internal: Login as the specified user
  #
  # user - User instance to login with
  def login_with(user, password, type = :local)
    visit new_user_session_path

    if type == :ldap
      user_input = 'username'
      password_input = 'password'
    else
      click_link 'Standard'
      user_input = 'user_username'
      password_input = 'user_password'
    end
    fill_in user_input, with: user
    fill_in password_input, with: password

    find("#tab-#{type} input[type=submit]").click
  end

  def logout
    click_link 'Logout' rescue nil
  end
end
