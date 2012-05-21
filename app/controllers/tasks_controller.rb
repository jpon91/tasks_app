class TasksController < ApplicationController
  def index
	@tasks = Task.all
	
  end

  def create

	@task = Task.create params[:task]
    
      if @task
        redirect_to @task#, notice: 'Post was successfully created.' 
        
      #else
       #  render action: "new" 
        
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
	@task.description=params[:task][:description]
	@task.priority=params[:task][:priority]
	@task.save
    redirect_to @task
  end

  def destroy
	Task.find_by_id(params[:id]).try(:delete)
    redirect_to tasks_path
  end
end
