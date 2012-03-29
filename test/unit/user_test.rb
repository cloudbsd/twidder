require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "invalid with empty attributes" do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
  # assert_equal I18n.translate('activerecord.errors.messages.empty'), user.errors[:name].join('; ')
  end
end
