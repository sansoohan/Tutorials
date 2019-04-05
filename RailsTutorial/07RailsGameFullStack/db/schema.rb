# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_25_112126) do

  create_table "game_clients", force: :cascade do |t|
    t.string "clientID"
    t.boolean "isRoomMaster"
    t.boolean "isReady"
    t.integer "roomNumber"
    t.integer "game_room_observer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_observer_id"], name: "index_game_clients_on_game_room_observer_id"
  end

  create_table "game_maps", force: :cascade do |t|
    t.integer "MAPCOL"
    t.integer "MAPROW"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_players", force: :cascade do |t|
    t.integer "suicideCount"
    t.integer "shipNum"
    t.integer "shipLength"
    t.integer "life"
    t.integer "game_room_observer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_observer_id"], name: "index_game_players_on_game_room_observer_id"
  end

  create_table "game_room_observers", force: :cascade do |t|
    t.integer "shipNum"
    t.integer "shipLength"
    t.integer "playerTurn"
    t.integer "roomNumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_ships", force: :cascade do |t|
    t.integer "MAPSIZE"
    t.integer "shipLength"
    t.integer "game_player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_player_id"], name: "index_game_ships_on_game_player_id"
  end

  create_table "map_spots", force: :cascade do |t|
    t.string "flag"
    t.integer "game_map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_map_id"], name: "index_map_spots_on_game_map_id"
  end

  create_table "ship_positions", force: :cascade do |t|
    t.integer "X"
    t.integer "Y"
    t.integer "game_ship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_ship_id"], name: "index_ship_positions_on_game_ship_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "user_pass"
    t.string "user_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
