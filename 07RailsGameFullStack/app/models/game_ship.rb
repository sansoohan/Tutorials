class GameShip < ApplicationRecord
  has_many :ship_positions, :class_name => "ShipPosition"
  belongs_to :game_room_bserver
  belongs_to :game_player
end