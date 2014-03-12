class CreateHeros < ActiveRecord::Migration
  def change
    create_table :heros do |t|
      t.integer :room_id
      t.integer :game_id
      t.integer :player_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
