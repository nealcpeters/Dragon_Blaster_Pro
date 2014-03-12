class MapsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @user_maps = @user.maps
  end

  def all
    @maps = Map.all
  end

  def new
    @user = current_user
    @map = Map.new
  end

  def create

  end
end
