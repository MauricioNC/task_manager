class TasksController < ApplicationController
  before_action :authorize
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end
  
  def show
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

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: "Task was updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :description, :priority_id)
  end
end
