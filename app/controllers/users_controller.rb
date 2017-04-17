class UsersController < ApplicationController
  
  	def show
    	@user = User.find(params[:id])
	end
  
	def new
    	@user = User.new
  	end

  	def create
    	@user = User.new(user_params)
    	@user.gender = params[:theme]
    	if @user.save
      		redirect_to user_url(@user)
    	else
      		render 'new'
    	end
  	end
  	
  	def append_gender 
  		@user = User.(params[i][id])
  		@user.gender 
  		@user.save
  		redirect_to users
  	end
  	
  	
  	private
    
	    def user_params
	      params.require(:user).permit(:name, :email, :password, :password_confirmation)
	    end
end
