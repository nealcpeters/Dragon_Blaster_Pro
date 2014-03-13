class Room < ActiveRecord::Base
  validates :map_id, presence: :true
  validates :title, presence: :true
  validates :description, presence: :true

  belongs_to :map

  def room_to_the_west
    Room.find(self.west_id)
  end

  def room_to_the_east
    Room.find(self.east_id)
  end

  def room_to_the_north
    Room.find(self.north_id)
  end

  def room_to_the_south
    Room.find(self.south_id)
  end
end
