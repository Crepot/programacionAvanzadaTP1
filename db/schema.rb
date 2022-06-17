# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_01_221506) do
  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "tokenAuth"
    t.boolean "sessionActive"
    t.string "symbol"
    t.string "password"
    t.string "email"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "positions", force: :cascade do |t|
    t.integer "box"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "table_players", force: :cascade do |t|
    t.integer "player_id"
    t.integer "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_table_players_on_player_id"
    t.index ["table_id"], name: "index_table_players_on_table_id"
  end

  create_table "table_positions", force: :cascade do |t|
    t.integer "position_id"
    t.integer "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position_id"], name: "index_table_positions_on_position_id"
    t.index ["table_id"], name: "index_table_positions_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "status_game"
    t.integer "winner"
    t.integer "moveNumber"
    t.integer "cuerret_player"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
