class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.integer :creater_id
      t.string :title
      t.text :description
      t.integer :size

      t.timestamps
    end
  end
end
