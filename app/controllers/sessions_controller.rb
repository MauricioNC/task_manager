class SessionsController < ApplicationController
  skip_before_action :authorize

  def login
    redirect_to tasks_path if logged_in?
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to tasks_path, success: "Welcome back! #{@user.username}" }
      end
    else
      respond_to do |format|
        format.html { render :login, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:error] = "Invalid email or password" }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've signed out successfully"
    redirect_to login_path
  end
end
