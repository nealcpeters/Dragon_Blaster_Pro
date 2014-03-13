class HerosController < ApplicationController

  def show
    @hero = Hero.find(params[:id])
    @current_room = Room.find(@hero.room_id)
  end


end
