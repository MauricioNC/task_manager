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
    @task = @current_user.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { flash.now[:success] = "Task '#{@task.task_name}' was successfully created" }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:error] = "Something went wrong creating new task, please try again" }
      end
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to tasks_path }
        format.turbo_stream { flash.now[:success] = "Task '#{@task.task_name}' was updated successfully" }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:error] = "Something went wrong updating task '#{@task.task_name}', please try again" }
      end
    end
  end

  def destroy
    if @task.destroy
      respond_to do |format|
        format.html
        format.turbo_stream { flash.now[:success] = "Task '#{@task.task_name}' was deleted successfully"}
      end
    else
      respond_to do |format|
        format.html { render :index, error: "Error deleting task '#{@task.task_name}', please try again", status: :unprocessable_entity }
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :description, :priority_id)
  end
end
