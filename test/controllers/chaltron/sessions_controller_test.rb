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
    assert_difference 'Log.count' do
      delete destroy_user_session_url
    end
  end

end
