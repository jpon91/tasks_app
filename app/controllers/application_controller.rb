class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
	
	if session[:user_id]
		if(User.exists?(session[:user_id]))
     			@current_user ||=User.find(session[:user_id])
		end
	end
  end
  
  def create_user(email,username,expires,token)
para=Hash.new
para[:email]=email.to_s
para[:username]=username.to_s
para[:facebooktoken]=token.to_s
para[:password]=token.to_s
para[:password_confirmation]=token.to_s
para[:expires]=expires.to_s
	a=User.new(para)
	if a.save 
		 a
	else
		nil#a.errors.full_messages
	end
  end

  def logged_in?
     	current_user.present?
  end

  def valido?
   if 	current_user.present?
	@current_user =User.find(session[:user_id])
	a=@current_user[:expires]
	
   else
	return nil
   end
  end
  helper_method :current_user, :logged_in?, :create_user, :valido?
  
end
