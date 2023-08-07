class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @user = User.first
    @task = @user.tasks.build(task_params)

    if @task.save
      redirect_to root_path, notice: "Task was successfully created."
    else
      render :new  
    end
  end

  def show
  end 

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :description, :priority_id)
  end
end
