require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get viewALL" do
    get notifications_viewALL_url
    assert_response :success
  end

end
