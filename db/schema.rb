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

ActiveRecord::Schema.define(version: 20161107222010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "season",                       null: false
    t.integer "week",                         null: false
    t.integer "away_score",                   null: false
    t.integer "home_score",                   null: false
    t.decimal "spread",                       null: false
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "user_id"
    t.boolean "overtime",     default: false, null: false
  end

  create_table "stats", force: :cascade do |t|
    t.integer "away_plays",                  null: false
    t.integer "away_yards",                  null: false
    t.integer "away_third_down_conversions", null: false
    t.integer "away_third_down_attempts",    null: false
    t.integer "away_penalties",              null: false
    t.integer "away_penalty_yards",          null: false
    t.integer "away_rushes",                 null: false
    t.integer "away_rushing_yards",          null: false
    t.integer "away_passes",                 null: false
    t.integer "away_passing_yards",          null: false
    t.string  "away_time_of_possession",     null: false
    t.integer "away_fumbles",                null: false
    t.integer "away_fumbles_lost",           null: false
    t.integer "away_interceptions",          null: false
    t.integer "home_plays",                  null: false
    t.integer "home_yards",                  null: false
    t.integer "home_third_down_conversions", null: false
    t.integer "home_third_down_attempts",    null: false
    t.integer "home_penalties",              null: false
    t.integer "home_penalty_yards",          null: false
    t.integer "home_rushes",                 null: false
    t.integer "home_rushing_yards",          null: false
    t.integer "home_passes",                 null: false
    t.integer "home_passing_yards",          null: false
    t.string  "home_time_of_possession",     null: false
    t.integer "home_fumbles",                null: false
    t.integer "home_fumbles_lost",           null: false
    t.integer "home_interceptions",          null: false
    t.integer "game_id"
    t.integer "away_completions",            null: false
    t.integer "home_completions",            null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "location",     null: false
    t.string "name",         null: false
    t.string "abbreviation", null: false
    t.string "division"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "team_id",                                   null: false
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "first_name",                                null: false
    t.string   "last_name",                                 null: false
    t.string   "role",                   default: "member", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
