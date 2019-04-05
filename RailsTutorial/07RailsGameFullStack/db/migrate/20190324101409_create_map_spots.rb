class CreateMapSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :map_spots do |t|
      t.string :flag
      t.belongs_to :game_map, foreign_key: true

      t.timestamps
    end
  end
end
