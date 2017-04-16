require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "valid signup" do
  	get signup_path => 'users#new'
  	before = User.count
  	post users_path, user: {name:'ahmed',email:'ahmed@yahoo.com',
  						   password:'qwerty',password_confirmation:'qwerty'}
  	after=User.count
  	assert_equal (before+1),after
  	follow_redirect!
  	assert_template 'users/show'
  end


end
