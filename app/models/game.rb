class Game < ActiveRecord::Base
  validates :player_id, presence: :true
  validates :map_id, presence: :true
  validates :room_id, presence: :true
  validates :hero_id, presence: :true

  belongs_to :player, class_name: 'User'
  belongs_to :room
  belongs_to :map
  belongs_to :hero

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

  def add_item_to_inventory
    room = Room.find(self.room_id)
    hero = Hero.find(self.hero_id)
    unless room.items.empty?
      item = room.items.first
      hero.items << item
      #This will automatically remove the item from the room's "inventory"
    else
      flash[:notice] = "This room has no items!"
      #redirect to some view
    end
  end

  #how do we make sure we are acting on duplicates of the rooms, not the master copy of the rooms when we alter inventories?

  def drop_item(item)
    #this will take an item from the hero's inventory and place it in the current room
  end

end
