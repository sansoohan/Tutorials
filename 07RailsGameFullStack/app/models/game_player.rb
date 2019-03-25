class GamePlayer < ApplicationRecord
  belongs_to :game_room_observer
  has_one :game_map, :dependent => :destroy
  has_one :game_client, :dependent => :destroy
  has_many :game_ship, :dependent => :destroy
end
