class HerosController < ApplicationController

  def show
    @hero = Hero.find(params[:id])
    @current_room = Room.find(@hero.room_id)
  end

  def index
    @user = User.find(session[:user_id])
    @hero = @user.heros.all
  end


end
