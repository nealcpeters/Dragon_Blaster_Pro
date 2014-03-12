class Map < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :rooms
  has_many :games
  has_many :heros, through: :games

end
