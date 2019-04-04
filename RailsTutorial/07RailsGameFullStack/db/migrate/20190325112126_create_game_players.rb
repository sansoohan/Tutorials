class CreateGamePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :game_players do |t|
      t.integer :suicideCount
      t.integer :shipNum
      t.integer :shipLength
      t.integer :life
      t.belongs_to :game_room_observer, foreign_key: true
      
      t.timestamps
    end
  end
end
