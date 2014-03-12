class Game < ActiveRecord::Base
  validates :player_id, presence: :true
  validates :map_id, presence: :true

  belongs_to :player, class_name: 'User'
  belongs_to :map
  has_one :hero
end
