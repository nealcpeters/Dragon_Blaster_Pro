class HerosController < ApplicationController



  def show
    @hero = Hero.find(params[:id])
  end

  def index
    @user = current_user
    @hero = @user.heros.all
  end


end
