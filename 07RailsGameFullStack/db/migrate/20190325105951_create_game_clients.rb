class CreateGameClients < ActiveRecord::Migration[5.2]
  def change
    create_table :game_clients do |t|
      t.string :clientID
      t.boolean :isRoomMaster
      t.boolean :isReady
      t.integer :roomNumber
      t.belongs_to :game_room_observer, foreign_key: true

      t.timestamps
    end
  end
end
