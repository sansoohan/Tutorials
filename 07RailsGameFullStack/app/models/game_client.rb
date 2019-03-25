class GameClient < ApplicationRecord
  has_one :game_room_observer, :class_name => "GameRoomObserver", :dependent => :destroy
  belongs_to :game_room_bserver
  belongs_to :game_player
end