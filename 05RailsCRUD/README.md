RailsCRUD
=====================
Make Data Array<br>
```
rails g model user user_id:string user_pass:text user_name:string user_email:string
rake db:migrate
```
<br>
Create Data<br>
```
rails c
user = User.new(:user_id => "sss", :user_pass => "sss", :user_name => "sss", :user_email => "sss")
user.save
user
User.create(:user_id => "ss", :user_pass => "ss", :user_name => "ss", :user_email => "ss")
```
<br>
Read Array<br>
```
users = User.all
users[1]
```
<br>
Select Data<br>
```
User.find(2)
User.find(2).user_id
User.where(user_id: "sss")[0]
User.where(user_id: "sss").select("user_name", "user_email")[0]
User.where("user_id = ? AND user_pass = ?", "sss", "sss")[0]
```
<br>
Update Data<br>
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
<br>
Delete Data<br>
```
User.create(:user_id => "ssss", :user_pass => "ssss", :user_name => "ssss", :user_email => "ssss")
user = User.where("user_id = ? AND user_pass = ?", "ssss", "ssss")[0]
user.destroy
```
<br>
Database Architect<br>
```
rake db:migrate VERSION=0
rails d model user
rails g model game_room players:has_many clients:has_many ships:has_many
rails g model player client:has_one ships:has_many game_room:belongs_to
rails g model client room_number:integer player:belongs_to game_room:gelongs_to
rails g model ship ship_length:integer player:belongs_to client:belongs_to
```
