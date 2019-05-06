class GamePlayer < ApplicationRecord
  belongs_to :game_room_observer, optional: true
  has_one :game_map, :dependent => :destroy
  has_many :game_ships, :dependent => :destroy
end
