require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'a new user should be created' do
    Role.create(name: 'admin')
    Role.create(name: 'user_admin')
    assert_difference 'User.count' do
      u = create(:user, roles: Role.all)
      assert u.has_role?(:admin)
      assert u.has_role?(:user_admin)
      assert u.has_role?('admin')
      assert u.has_role?('user_admin')
    end
  end

  test 'username should be present' do
    record = build(:user, username: '')
    assert_equal false, record.valid?
    assert_not_empty record.errors[:username]
  end

  test 'username should be unique' do
    user = create(:user)
    record = build(:user, username: user.username)
    assert_equal false, record.valid?
    assert_not_empty record.errors[:username]
  end

end
