class SessionsController < ApplicationController

	@flagLoginError = 0

  def new
  end

  def create
  	user = User.find_by(email:params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		redirect_to user_url(user)
  		log_in user

  	else
  		@flagLoginError = 1
  		flash[:danger] = "Invalid Email Or password"
  		render 'new'
  	end

  end

  def destroy
  	log_out()
  	redirect_to signup_path
  end


end
