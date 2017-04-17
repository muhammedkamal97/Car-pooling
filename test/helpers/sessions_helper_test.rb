require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  include SecureRandom
  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    u = current_user
    assert_equal @user, u
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(SecureRandom.urlsafe_base64))
    assert_nil @current_user
  end
end