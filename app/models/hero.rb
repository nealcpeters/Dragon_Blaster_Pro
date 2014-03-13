class Hero < ActiveRecord::Base
  validates :player_id, presence: :true
  validates :name, presence: :true, uniqueness: :true
  validates :description, presence: :true

  belongs_to :player, class_name: 'User'
  has_many :games

  def move_hero_east
    room = Room.find(self.room_id)
    self.update(room_id: room.room_to_the_east.id)
  end

  def move_hero_west
    room = Room.find(self.room_id)
    self.update(room_id: room.room_to_the_west.id)
  end

  def move_hero_south
    room = Room.find(self.room_id)
    self.update(room_id: room.room_to_the_south.id)
  end

  def move_hero_north
    room = Room.find(self.room_id)
    self.update(room_id: room.room_to_the_north.id)
  end
end
