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

ActiveRecord::Schema.define(version: 20170611181132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mod_releases", force: :cascade do |t|
    t.bigint "mod_id"
    t.string "version"
    t.string "game_version"
    t.string "min_game_version"
    t.text "download_url"
    t.text "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mod_id"], name: "index_mod_releases_on_mod_id"
  end

  create_table "mods", force: :cascade do |t|
    t.string "name"
    t.text "title"
    t.text "summary"
    t.text "description"
    t.text "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
    t.datetime "auth_issued"
    t.json "privs"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "mod_releases", "mods"
end
