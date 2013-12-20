class SessionsController < ApplicationController 
  def new
    if logged_in?
      redirect_to search_index_path
    end
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
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end