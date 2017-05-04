class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email:params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
  	else
  		$flagLoginError = 1
  		flash[:danger] = "Invalid Email Or password"
  		redirect_to signup_path
  	end
  end



  def destroy
  	if (logged_in?)
  		log_out
  	end  
  	redirect_to signup_path
  end


end
