class Hero < ActiveRecord::Base
  validates :room_id, presence: :true
  validates :game_id, presence: :true
  validates :player_id, presence: :true
  validates :name, presence: :true, uniqueness: :true
  validates :description, presence: :true

  belongs_to :room
  belongs_to :player, class_name: 'User'
  belongs_to :game

  def move_hero_east
    # Hero
  end

  def move_hero_west

  end

  def move_hero_south

  end

  def move_hero_north

  end
end
