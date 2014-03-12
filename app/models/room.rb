class Room < ActiveRecord::Base
  validates :map_id, presence: :true
  validates :title, presence: :true
  validates :description, presence: :true

  belongs_to :map


end
