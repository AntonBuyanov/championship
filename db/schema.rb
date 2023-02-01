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

ActiveRecord::Schema.define(version: 2023_02_01_053605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "match_id", null: false
    t.bigint "indicator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["indicator_id"], name: "index_achievements_on_indicator_id"
    t.index ["match_id"], name: "index_achievements_on_match_id"
    t.index ["player_id"], name: "index_achievements_on_player_id"
  end

  create_table "indicators", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "team_first_id", null: false
    t.bigint "team_second_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_first_id"], name: "index_matches_on_team_first_id"
    t.index ["team_second_id"], name: "index_matches_on_team_second_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.integer "number", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "achievements", "indicators"
  add_foreign_key "achievements", "matches"
  add_foreign_key "achievements", "players"
  add_foreign_key "matches", "teams", column: "team_first_id"
  add_foreign_key "matches", "teams", column: "team_second_id"
  add_foreign_key "players", "teams"
end
