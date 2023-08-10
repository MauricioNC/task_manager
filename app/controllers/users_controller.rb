class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, only: [:show, :update, :destroy]

  def new
    redirect_to tasks_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { flash.now[:success] = "User '#{@user.username}' was created successfully" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { flash.now[:error] = "Unable to update user '#{@user.username}' information, please try again" }
      end
    end
  end

  def destroy
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to login_path }
        format.turbo_stream { flash.now[:success] = "User '#{@user.username}' was deleted successfully" }
      end
    else
      respond_to do |format|
        format.html { redirect_to tasks_path }
        format.turbo_stream { flash.now[:error] = "Something went wrong deleting '#{@user.username}' user, please try again" }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
