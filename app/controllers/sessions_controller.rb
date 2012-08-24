class SessionsController < ApplicationController
  def new
  end

  def create
	@user=User.find_by_email(params[:email])
	if @user && @user.authenticate(params[:password])
		session[:user_id]=@user.id
		redirect_to root_path, notice: "Inicio de sesion exitoso!"
	else
		flash.now[:notice]= ""
		render :new
	end
		
			  
  end
  def destroy
  	session[:user_id]=nil
	redirect_to root_path, notice: "Sesion Finalizada!"
  end
end
