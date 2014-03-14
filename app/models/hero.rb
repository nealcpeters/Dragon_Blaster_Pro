class Hero < ActiveRecord::Base
  validates :player_id, presence: :true
  validates :name, presence: :true, uniqueness: :true
  validates :description, presence: :true

  belongs_to :player, class_name: 'User'
  has_many :games
  has_many :items, as: :owner

end
