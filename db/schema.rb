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

ActiveRecord::Schema[7.0].define(version: 2022_05_21_222334) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_results", force: :cascade do |t|
    t.bigint "home_team_id", null: false
    t.integer "home_goals"
    t.integer "home_red_cards"
    t.bigint "away_team_id", null: false
    t.integer "away_goals"
    t.integer "away_red_cards"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_team_id"], name: "index_match_results_on_away_team_id"
    t.index ["home_team_id"], name: "index_match_results_on_home_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_teams_on_discarded_at"
  end

  add_foreign_key "match_results", "teams", column: "away_team_id"
  add_foreign_key "match_results", "teams", column: "home_team_id"
end
