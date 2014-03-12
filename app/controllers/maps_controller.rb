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
    @map = Map.new(map_params)
    if @map.save
      render :json => {map_id: @map.id}
    else
      render :json => {map_id: nil}
    end
  end

  def map_params
    params.require(:map).permit(:title, :description, :user_id, :north_id, :south_id, :east_id, :west_id)
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
