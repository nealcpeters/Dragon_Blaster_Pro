class Map < ActiveRecord::Base
  validates :creator_id, presence: :true
  validates :title, presence: :true, uniqueness: :true
  validates :description, presence: :true

  belongs_to :creator, class_name: 'User'
  has_many :rooms
  has_many :games
  has_many :heros, through: :games

end
