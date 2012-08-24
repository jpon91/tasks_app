class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
	
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show

     
    if params[:id]=session[:user_id]
@user = User.find(params[:id])
url=URI("https://graph.facebook.com/me/picture?type=large&access_token=#{@user[:facebooktoken]}")
resource = RestClient::Resource.new ((url.to_s))
a=resource.get

#send_data a, :filename => 'icon.jpg', :type => 'image/jpeg', :disposition => 'inline'

data_uri = Base64.encode64(a).gsub(/\n/, "")
image_tag = '<img id="image" alt="sample" src="data:image/png;base64,%s">' % data_uri
url=URI("https://graph.facebook.com/me?access_token=#{@user[:facebooktoken]}")
resource = RestClient::Resource.new ((url.to_s))
a=resource.get
a=ActiveSupport::JSON.decode(a)
	time=Time.now.year
    @pic=image_tag
    @name=a["name"] 
    @edad=time.to_i-(a["birthday"].to_s)[6..-1].to_i
    @userid=a["id"]
#url=URI("https://graph.facebook.com/me/gradesdisplay:develop")
#resource = RestClient::Resource.new ((url.to_s))
#a=resource.post :access_token => "#{@user[:facebooktoken]}" , :website => 'http://morning-rain-8661.herokuapp.com/ruby.html'
#return render :text => "que pasa #{a}"
    respond_to do |format|
      format.html # show.html.erb
  
      format.json { render json: @user }
    end 
  else
    redirect_to root_path, notice: "Debe iniciar sesion"
end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
return render :text => params[:user]
    respond_to do |format|
      if @user.save
	session[:user_id]=@user.id
        format.html { redirect_to @user, notice: 'Usiario creado exitosamente' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Usuario actualizado con exito' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
