class CreateGameShips < ActiveRecord::Migration[5.2]
  def change
    create_table :game_ships do |t|
      t.integer :MAPSIZE
      t.integer :shipLength
      t.belongs_to :game_player, foreign_key: true

      t.timestamps
    end
  end
end
