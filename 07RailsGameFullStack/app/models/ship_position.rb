class ShipPosition < ApplicationRecord
  belongs_to :game_ship, optional: true
end
