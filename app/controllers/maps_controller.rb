class MapsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @user_maps = @user.maps
  end

  def all
    @maps = Map.all
  end

  def new
    @user = User.find(params[:user_id])
    @map = Map.new
  end

  def create

  end

  def edit
  end

  def destroy
    @user = User.find(params[:user_id])
    @map = @user.maps.find(params[:id])
    @map.destroy

    redirect_to action: :index
  end
end
