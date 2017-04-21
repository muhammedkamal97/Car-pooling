module SessionsHelper
	# Method to log the user 
	def log_in(user)
		session[:user_id] = user.id
	end
	#dealing with the loggedin user
	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id:session[:user_id])
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
      		if user && user.authenticated?(cookies[:remember_token])
        		log_in user
        		@current_user = user
        	end
		end
	end

	def logged_in?
	  !current_user.nil?
	end

	def log_out
		session[:user_id] = nil
		@current_user = nil
	end
	#remember a user (login without write email or password)
	def remember(user)
		user.remember_database
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
	
	def current_user
		@user == current_user
	end
	
	def forget (user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	
	def gen
		@user.addgender(params[:theme])
	end
end
