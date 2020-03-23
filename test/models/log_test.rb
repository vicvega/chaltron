require 'test_helper'

class LogTest < ActiveSupport::TestCase

  test 'message should be present' do
    record = build(:log, message: nil)
    assert_equal false, record.valid?
    assert_not_empty record.errors[:message]
  end

  test 'message should be truncated' do
    too_long_message = 'x' * 1500
    record = build(:log, message: too_long_message)
    assert_equal true, record.valid?
    assert_equal 1000, record.message.length
  end

  test 'severity should be present' do
    record = build(:log, severity: nil)
    assert_equal false, record.valid?
    assert_not_empty record.errors[:severity]
  end

  test 'severity should be included in syslog standard severities' do
    record = build(:log, severity: 'something')
    assert_equal false, record.valid?
    assert_not_empty record.errors[:severity]
  end

  test 'severity should be standarized' do
    record = build(:log, severity: 'error')
    assert_equal true, record.valid?
    assert_equal 'err', record.severity
  end

end
