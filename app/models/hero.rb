class Hero < ActiveRecord::Base
  belongs_to :room
  belongs_to :player, class_name: 'User'
  belongs_to :game
end
