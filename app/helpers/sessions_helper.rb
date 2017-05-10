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
		forget(current_user)

    	session.delete(:user_id)
    	@current_user = nil
	end
	#remember a user (login without write email or password)
	def remember(user)
		user.remember_database
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
	def forget (user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	
	def gen
		@user.addgender(params[:theme])
	end

	def distance (loc1, loc2)
		if(loc1 && loc2)
	  		rad_per_deg = Math::PI/180  # PI / 180
	  		rkm = 6371                  # Earth radius in kilometers
	  		rm = rkm * 1000             # Radius in meters

		    dlat_rad = (loc2.to_lat-loc1.to_lat) * rad_per_deg  # Delta, converted to rad
		    dlon_rad = (loc2.to_long-loc1.to_long) * rad_per_deg
		    l = []
		    l1 =[]
		    l.insert(0, loc1.to_lat)
		    l.insert(1, loc1.to_long)
		    l1.insert(0, loc2.to_lat)
		    l1.insert(1, loc2.to_long)

		    lat1_rad, lon1_rad = l.map {|i| i * rad_per_deg }
		    lat2_rad, lon2_rad = l1.map {|i| i * rad_per_deg }

		    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
		    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
		    rm * c # Delta in meters
		end
	end	
end
