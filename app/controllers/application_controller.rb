class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  $flagLoginError = 0
  
  include SessionsHelper
  def welcome
  	render text:"hello"
  end


end
