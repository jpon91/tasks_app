class TasksController < ApplicationController

  def index
	@tasks = Task.all
	if params[:code]
	   
url=URI("https://graph.facebook.com/oauth/access_token?client_id=520054624688382&redirect_uri=http://127.0.0.1:5000/&client_secret=9f902797bc31c0d17c7de25d925e57ee&code=#{params[:code]}")
resource = RestClient::Resource.new ((url.to_s))
a=resource.get

if a.to_s=~ /access_token=(.*)&expires=(.*)/

	cadena=(a.split "access_token=")[1]
	token=(cadena.split "&expires=")[0].to_s
	expires=(cadena.to_s.split "&expires=")[1].to_s
url=URI("https://graph.facebook.com/me?access_token=#{token}")
resource = RestClient::Resource.new ((url.to_s))
a=resource.get
b=Hash.new
a=ActiveSupport::JSON.decode(a)
#return render :text => "que pasa #{a["id"]}"
#a.to_s.gsub("{","").gsub("}","").gsub("\"","").html_safe.split(",").each do |arr|
#	arr=arr.split(":")
#	b[arr[0]]=arr[1]
#end


	if User.find_by_username(a["username"])
		v=User.find_by_username(a["username"])
	else
		v=create_user(a["email"],a["username"],token)
	end
if v
	
	session[:user_id]=v[:id]
        #return render :text => "que pasa #{v[:email]}"

        redirect_to "/users/#{v[:id]}/", notice: "Welcome"
        #format.json { render json: v, status: :created, location: v }	
else
	return render :text => "hola"
end

#return render :text => a
else

end


end
	
  end

  def create

	@task = Task.new params[:task]
	@task[:user_id]= session[:user_id]
    
      if @task.valid?
	@task.save	
        redirect_to @task#, notice: 'Post was successfully created.' 
        
      else
         render :new 
        
      end
    
  end

  def new
	@task = Task.new
  end

  def edit
	@task = Task.find(params[:id])
  end

  def show
	@task = Task.find(params[:id])
  end

  def update
	@task = Task.find(params[:id])
	if(@task.update_attributes(params[:task]))
		redirect_to @task
	else
		render :edit
	end
	
    
  end

  def destroy
	Task.find_by_id(params[:id]).try(:delete)
    redirect_to tasks_path
  end
end