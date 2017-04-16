require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get Welcome" do
    get :Welcome
    assert_response :success
  end

end
