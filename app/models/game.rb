class Game < ActiveRecord::Base
  belongs_to :player, class_name: 'User'
  belongs_to :map
  has_one :hero
end
