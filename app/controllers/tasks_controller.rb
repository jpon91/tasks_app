class TasksController < ApplicationController
  def index
	@tasks = Task.all
  end

  def create
	@task = Task.create params[:task]
    redirect_to @task
  end

  def new
	@task = Task.new
  end

  def edit
  end

  def show
	@task = Task.find(params[:id])
  end

  def update
  end

  def destroy
	Task.find_by_id(params[:id]).try(:delete)
    redirect_to tasks_path
  end
end
