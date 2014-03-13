class SessionsController < ApplicationController
  def new
  end

  def create
    puts "We are in the Create Method"
    user = User.find_by_username(params[:username])
    p user
    if user && user.authenticate(params[:password])
      puts "We are authenticated and should be redirected"
      session[:user_id] = user.id
      redirect_to profile_path, notice: 'Logged in!'
    else
      puts "We have entered the wrong info"
      flash.now.alert = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
