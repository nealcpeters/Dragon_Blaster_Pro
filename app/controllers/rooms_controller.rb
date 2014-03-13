class RoomsController < ApplicationController

  def create
    @room = Room.new(room_params)

    if @room.save
      render :json => {room_id: @room.id}
    else
      render :json => {room_id: nil}
    end
  end

  def room_params
    params.permit(:title, :description, :map_id)
  end

end
