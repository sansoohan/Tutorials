RailsFullStack
=============================
<a href="https://bootsnipp.com/snippets/vl4R7">Get The Login Template</a><br>
<br>

UI First
-------------------------
You don't have to make database structure first.<br>
You need to know what kind of data is needed.<br>
You don't know the design you made is good or not.<br>
So you need to make UI function, at least.<br>
But you don't have any database yet. You can use sample data so call as 'Mock Data'.<br>
Show your UI to your client and get the OK sign from them.<br>

Database Architect (Same As 03RubyGameServer)
---------------------------
You can use the logic you made before.<br>
In here, I recommend you to use logic of 03RubyGameServer<br>
<br>
Relation<br>
Database table is a sort of Directory.<br>
Some Directory has many Directories.<br>
Some Table has many Tables.<br>
Here is the example<br>
Some Table <strong>has_many</strong> tables. tables <strong>belongs_to</strong> Some Table<br>
Some Table <strong>has_one</strong> table. table <strong>belongs_to</strong> Some Table<br>
<br>
Cascading<br>
You need to destroy Child Table when Parent Table destoried<br>
<strong>:dependent => :destroy</strong><br>
<br>
Null Reference<br>
You need to enable null true for foreign key(id), or you will get database null false error.<br>
<strong>:optional => true</strong><br>
<br>
Analyze these code<br>
```
rails g model game_map \
    MAPCOL:integer \
    MAPROW:integer \
    game_player:belongs_to

class GameMap < ApplicationRecord
    has_many :map_spots, :class_name => "MapSpot", :dependent => :destroy
end

rails g model map_spot \
    flag:string \
    game_map:belongs_to

rails g model GameClient \
    clientID:string \
    isRoomMaster:boolean \
    isReady:boolean \
    roomNumber:integer \
    game_room_observer:belongs_to

class GameClient < ApplicationRecord
    belongs_to :game_room_observer, :optional => true
end

rails g model GameShip \
    MAPSIZE:integer \
    shipLength:integer \
    game_player:belongs_to

class GameShip < ApplicationRecord
    has_many :ship_positions, :class_name => "ShipPosition", :dependent => :destroy
    belongs_to :game_player, :optional => true
end

rails g model ShipPosition \
    X:integer \
    Y:integer \
    game_ship:belongs_to

rails g model GameRoomObserver \
    shipNum:integer \
    shipLength:integer \
    playerTurn:integer \
    roomNumber:integer

class GameRoomObserver < ApplicationRecord
    has_many :game_clients, :class_name => "GameClient", :dependent => :destroy
    has_many :game_players, :class_name => "GamePlayer", :dependent => :destroy
end

rails g model GamePlayer \
    suicideCount:integer \
    shipNum:integer \
    shipLength:integer \
    life:integer \
    game_room_observer:belongs_to

class GamePlayer < ApplicationRecord
    has_one :game_map, :dependent => :destroy
    has_many :game_ships, :dependent => :destroy
    belongs_to :game_room_observer, :optional => true
end

rake db:migrate
```

Logic inside of Model
---------------------------
Bring Your Logic And Paste it inside the model.<br>

Finish the Controller
---------------------------
Replace Mock-up Data to Database data.<br>

Refactoring UI
------------------
Make UI Better and remove some UI that is not matched.<br>

Refactoring Structure
------------------------
Make Code beautiful.<br>
The more patch work you do, the more ugly code come out.<br>
You need to clean your room sometimes.<br>
If you think it is really hard to do something with your code, that is the time you need to refactoring.<br>
This job is a sort of Version Up.<br>
