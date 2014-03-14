class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Signed Up!'
    else
      render 'new'
    end
  end

  def show
    @user = User.where(id: session[:user_id]).first
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    @user.update_attributes(user_params)
    redirect_to user_path(@user), notice: 'Profile Updated!'
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
