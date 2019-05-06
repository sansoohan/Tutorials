require 'securerandom'
class GameShip < ApplicationRecord
    has_many :ship_positions, :class_name => "ShipPosition"
    belongs_to :game_player, optional: true

    def init(shipLength)
        self.MAPSIZE = 7
        self.shipLength = shipLength
        setPosition
        self.save
    end
    def setPosition
        mapSize = self.MAPSIZE
        shipLength = self.shipLength
        direction = SecureRandom.random_number(2)
        shortPos = SecureRandom.random_number(mapSize - shipLength + 1)
        longPos = SecureRandom.random_number(mapSize)
        shipArray = []
        for i in (0..shipLength-1) do
            if direction == 0
                posX = shortPos + i
                posY = longPos
            else
                posX = longPos
                posY = shortPos + i
            end
            self.ship_positions.push(ShipPosition.new(:X => posX, :Y => posY))
        end
    end
    def hasCollision(shipList)
        if shipList
            for savedShip in shipList do
                for savedShipPos in (0..savedShip.shipLength-1) do
                    for thisShipPos in (0..self.shipLength-1) do
                        if (savedShip.posX[savedShipPos] == posX[thisShipPos]) && (savedShip.posY[savedShipPos] == posY[thisShipPos])
                            return true
                        end
                    end
                end
            end
        end
        false
    end
    def posX
        posXArray = []
        for pos in self.ship_positions do
            posXArray.push(pos.X)
        end
        posXArray
    end
    def posY
        posYArray = []
        for pos in self.ship_positions do
            posYArray.push(pos.Y)
        end
        posYArray
    end
end