RailsCRUD
=====================

Make Data Array
------------------------
```
rails g model user user_id:string user_pass:text user_name:string user_email:string
rake db:migrate
```

Create Data
------------------------
```
rails c
user = User.new(:user_id => "sss", :user_pass => "sss", :user_name => "sss", :user_email => "sss")
user.save
user
User.create(:user_id => "ss", :user_pass => "ss", :user_name => "ss", :user_email => "ss")
```

Read Array
------------------------
```
users = User.all
users[1]
```

Select Data
------------------------
```
User.find(2)
User.find(2).user_id
User.where(user_id: "sss")[0]
User.where(user_id: "sss").select("user_name", "user_email")[0]
User.where("user_id = ? AND user_pass = ?", "sss", "sss")[0]
```

Update Data
------------------------
```
user = User.find(1)
user.user_name = "SSS"
user.save
User.find(1).user_name
user.update_attribute(:user_name, "SSD")
User.find(1).user_name
user.update_attributes(:user_name => "SSD", :user_email => "DSS")
User.find(1)
```

Delete Data
------------------------
```
User.create(:user_id => "ssss", :user_pass => "ssss", :user_name => "ssss", :user_email => "ssss")
user = User.where("user_id = ? AND user_pass = ?", "ssss", "ssss")[0]
user.destroy
```

Database Architect
------------------------
```
rake db:migrate VERSION=0
rails d model user

rails g model game_map \
    MAPCOL:integer:7 \
    MAPROW:integer:7 \
    GamePlayer:belongs_to

class GameMap < ApplicationRecord
    has_many :map_spots, :class_name => "MapSpot", :dependent => :destroy
end
```
