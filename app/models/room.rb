class Room < ActiveRecord::Base
  validates :map_id, presence: :true
  validates :title, presence: :true
  validates :description, presence: :true

  has_many :items, as: :owner
  belongs_to :map

  def room_to_the_west
    Room.find(self.west_id) if west_id
  end

  def room_to_the_east
    Room.find(self.east_id) if east_id
  end

  def room_to_the_north
    Room.find(self.north_id) if north_id
  end

  def room_to_the_south
    Room.find(self.south_id) if south_id
  end

  def update_neighbors
    room_to_the_north.south_id = id if room_to_the_north
    room_to_the_south.north_id = id if room_to_the_south
    room_to_the_east.west_id = id if room_to_the_east
    room_to_the_west.east_id = id if room_to_the_west
  end

end
