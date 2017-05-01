require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
   end

     test "login with remembering" do
        log_in_as(@user, remember_me: '1')
        assert_not_nil cookies['remember_token']
     end

   test "login without remembering" do
     log_in_as(@user, remember_me: '0')
     assert_nil cookies['remember_token']
   end
end
