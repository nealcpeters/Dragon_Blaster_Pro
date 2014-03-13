class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.integer :creator_id
      t.string :title
      t.text :description
      t.integer :size, :default => 25
      t.integer :starting_room_id

      t.timestamps
    end
  end
end
