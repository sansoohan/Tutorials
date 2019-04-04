class CreateGameMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :game_maps do |t|
      t.integer :MAPCOL
      t.integer :MAPROW
      
      t.timestamps
    end
  end
end
