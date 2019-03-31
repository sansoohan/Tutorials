class MapSpot < ApplicationRecord
  belongs_to :game_map, optional: true
end
