class GameRoomObserver < ApplicationRecord
  has_and_belongs_to_many :game_client, :dependent => :destroy
  has_many :game_ship, :class_name => "GameShip", :dependent => :destroy
  has_many :game_player, :class_name => "GamePlayer", :dependent => :destroy
end