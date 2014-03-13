class RoomsController < ApplicationController

  def create
    puts "========================= you did it!!! ==============================="
    puts params
    puts room_params
    @room = Room.new(room_params)
    if @room.save
      render :json => {room_id: @room.id}
    else
      render :json => {room_id: nil}
    end
  end

  def room_params
    params.require(:room).permit(:title, :description, :map_id)
  end

end
