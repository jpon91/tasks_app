class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
	
	if session[:user_id]
		if(User.exists?(session[:user_id]))
     			@current_user ||=User.find(session[:user_id])
		end
	end
  end

  def logged_in?
     	current_user.present?
  end
  helper_method :current_user, :logged_in?
  
end
