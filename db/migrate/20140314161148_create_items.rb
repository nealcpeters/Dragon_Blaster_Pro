class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
