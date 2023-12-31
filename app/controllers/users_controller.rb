class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, only: [:show, :update, :destroy]

  def new
    redirect_to tasks_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to tasks_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    unless @user.update(user_params)
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to login_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to tasks_path }
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
