class UsersController < ApplicationController
  	before_action :logged_in_user, only: [:edit, :update]
	before_action :current_user, only: [:edit, :update]

  
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
    		log_in(@user)
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
  	def edit
  		@user = User.find(params[:id])
  	end
  	def update
  		@user = User.find(params[:id])
  		if @user.update_attributes(user_params)
  			flash[:success] = "Profile update"
  			redirect_to @user
  		else
  			render 'edit'
  		end
  	end
  	
  	
  	private
    
	    def user_params
	      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone)
	    end
	    # before filters 
	    #confirm a logged in user
	    def logged_in_user
	    	unless logged_in?
	    	flash[:danger] = "Please log in."
	    	redirect_to login_url 
	    end
	    end
	    def correct_user
	    	@user = User.find(params[:id])
	    	redirect_to(root_url) unless @user = current_user?(@user)
	    end
end
