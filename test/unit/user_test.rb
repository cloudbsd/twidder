require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # EXAMPLE:
  #
  # ActiveModel handles most of the errors, so the error messages are in errors.messages. The only exception is taken, because the uniqueness validation is ActiveRecord specific.
  #
  # So you'll need:
  #
  # assert_equal I18n.translate('errors.messages.too_short', :count=>10), product.errors[:title].join('; ')
  #

  test "invalid with empty attributes" do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
    assert_equal I18n.translate('errors.messages.blank'), user.errors[:email].join('; ')
    assert_equal I18n.translate('errors.messages.blank'), user.errors[:name].join('; ')
  end
end
