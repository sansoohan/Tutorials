class GameMap < ApplicationRecord
    has_many :map_spots, :class_name => "MapSpot", :dependent => :destroy

    def init
        mapArray = []
        for i in (1..49) do
            mapArray.push(MapSpot.new(:flag => '[??]'))
        end
        self.map_spots.push(mapArray)
    end

    def getPosition(row, col)
        self.map_spots[row*7 + col].flag
    end
    def setPosition(row, col, flag)
        self.map_spots[row*7 + col].flag = flag
        self.map_spots[row*7 + col].save
    end
end