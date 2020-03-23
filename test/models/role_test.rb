require 'test_helper'

class RoleTest < ActiveSupport::TestCase

  test 'name must be present' do
    record = build(:role, name: nil)
    assert_equal false, record.valid?
    assert_not_empty record.errors[:name]
  end

  test 'name must be unique' do
    role = create(:role)

    record = build(:role, name: role.name)
    assert_equal false, record.valid?
    assert_not_empty record.errors[:name]
  end

end
