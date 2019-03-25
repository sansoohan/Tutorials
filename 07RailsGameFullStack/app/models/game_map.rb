class GameMap < ApplicationRecord
    has_many :map_spots, :class_name => "MapSpot", :dependent => :destroy
end