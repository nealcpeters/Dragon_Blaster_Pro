class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :map_id
      t.string :title
      t.text :description
      t.boolean :visited, default: false
      t.integer :north_id
      t.integer :south_id
      t.integer :east_id
      t.integer :west_id

      t.timestamps
    end
  end
end
