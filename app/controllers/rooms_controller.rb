class RoomsController < ApplicationController

  def create
    @room = Room.new(room_params)
    if @room.save
      render :json => {room_id: @room.id}
    else
      render :json => {room_id: nil}
    end
  end


end
