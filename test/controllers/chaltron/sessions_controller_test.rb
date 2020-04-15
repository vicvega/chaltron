require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:user)
  end

  test 'should generate log message after login' do
    assert_difference 'Log.count' do
      post user_session_url, params:
        { user: { login: @user.username, password: @user.password } }
    end
  end

  test 'should generate log message after logout' do
    sign_in @user
    # 2 log messages are generated:
    # - after_set_user
    # - before_logout 
    assert_difference 'Log.count', 2 do
      delete destroy_user_session_url
    end
  end

end
