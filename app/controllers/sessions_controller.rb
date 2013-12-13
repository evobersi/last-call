class SessionsController < ApplicationController 
  def new
  end

  def create
    auth = User.from_omniauth(env["omniauth.auth"])
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to login_path, notice: "Logged in!"
    elsif auth
      session[:user_id] = auth.id
      redirect_to login_path, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end