class GameRoomObserver < ApplicationRecord
  has_many :game_clients, :class_name => "GameClient", :dependent => :destroy
  has_many :game_players, :class_name => "GamePlayer", :dependent => :destroy
end