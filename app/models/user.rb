class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: :true, uniqueness: :true
  validates :email, presence: :true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :password_digest, presence: :true, :length => { :minimum => 4 }

  has_many :maps, foreign_key: "creator_id"
  has_many :heros, foreign_key: "player_id"
  has_many :games, foreign_key: "player_id"
end
