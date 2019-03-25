RailsFullStack
=============================
<a href="https://bootsnipp.com/snippets/vl4R7">Get The Login Template</a><br>
<br>

Database Architect (Same As 03RubyGameServer)
---------------------------
```
rails g model game_map \
    MAPCOL:integer:7 \
    MAPROW:integer:7 \
    GamePlayer:belongs_to

class GameMap < ApplicationRecord
    has_many :map_spots, :class_name => "MapSpot", :dependent => :destroy
end

rails g model map_spot \
    flag:string \
    game_map:belongs_to

rails g model GameClient \
    clientID:string \
    isRoomMaster:boolean \
    isReady:boolean:false \
    roomNumber:integer \
    game_room_bserver:belongs_to \
    game_player:belongs_to

class GameClient < ApplicationRecord
    has_one :game_room_observer, :class_name => "GameRoomObserver", :dependent => :destroy
    belongs_to :game_room_bserver
    belongs_to :game_player
end

rails g model GameShip \
    MAPSIZE:integer \
    shipLength:integer \
    game_room_bserver:belongs_to \
    game_player:belongs_to

class GameShip < ApplicationRecord
    has_many :ship_positions, :class_name => "ShipPosition", :dependent => :destroy
    belongs_to :game_room_bserver
    belongs_to :game_player
end

rails g model ShipPosition \
    posX:integer \
    posY:integer \
    game_ship:belongs_to

rails g model GameRoomObserver \
    shipNum:integer \
    shipLength:integer \
    playerTurn:integer \
    roomNumber:integer \
    game_client:belongs_to

class GameRoomObserver < ApplicationRecord
    has_and_belongs_to_many :game_client, :dependent => :destroy
    has_many :game_ship, :class_name => "GameShip", :dependent => :destroy
    has_many: game_player, :class_name => "GamePlayer", :dependent => :destroy
end

rails g model GamePlayer \
    suicideCount:integer \
    shipNum:integer \
    shipLength:integer \
    life:integer \
    game_room_observer:belongs_to

class GamePlayer < ApplicationRecord
    has_one :game_map, :dependent => :destroy
    has_one :game_client, :dependent => :destroy
    has_many :game_ship, :dependent => :destroy
end

rake db:migrate
```
