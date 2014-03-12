class User < ActiveRecord::Base
  has_secure_password

  has_many :maps, foreign_key: "creator_id"
  has_many :heros, foreign_key: "player_id"
  has_many :games, foreign_key: "player_id"

end
