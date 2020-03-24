require 'test_helper'

class LogsControllerTest < ActionDispatch::IntegrationTest
  def setup
    admin_role = create(:role, name: :admin)
    @log = create(:log)
    @admin = create(:user, roles: [admin_role])
  end

  test 'should not get index if not authenticated' do
    get logs_url
    assert_response :redirect
  end

  test 'should not get index if not authorized' do
    get logs_url
    sign_in create(:user)
    assert_response :redirect
  end

  test 'should get index if authorized' do
    sign_in @admin
    get logs_url
    assert_response :success
  end

  test 'should get show' do
    sign_in @admin
    get log_url(@log)
    assert_response :success
  end

end
