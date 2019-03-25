class CreateGameRoomObservers < ActiveRecord::Migration[5.2]
  def change
    create_table :game_room_observers do |t|
      t.integer :shipNum
      t.integer :shipLength
      t.integer :playerTurn
      t.integer :roomNumber
      t.belongs_to :gameClient, foreign_key: true

      t.timestamps
    end
  end
end
