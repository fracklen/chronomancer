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

ActiveRecord::Schema.define(version: 20170227215125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alert_integrations", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "kind"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.index ["team_id"], name: "index_alert_integrations_on_team_id", using: :btree
  end

  create_table "alerts", force: :cascade do |t|
    t.integer  "canary_id"
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canary_id"], name: "index_alerts_on_canary_id", using: :btree
  end

  create_table "canaries", force: :cascade do |t|
    t.string   "name"
    t.string   "schedule"
    t.integer  "team_id"
    t.text     "comment"
    t.string   "uuid"
    t.integer  "created_by_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "last_checkin"
    t.datetime "next_checkin"
    t.integer  "alert_integration_id"
    t.index ["alert_integration_id"], name: "index_canaries_on_alert_integration_id", using: :btree
    t.index ["created_by_id"], name: "index_canaries_on_created_by_id", using: :btree
    t.index ["team_id"], name: "index_canaries_on_team_id", using: :btree
    t.index ["uuid"], name: "index_canaries_on_uuid", unique: true, using: :btree
  end

  create_table "checkins", force: :cascade do |t|
    t.integer  "canary_id"
    t.string   "user_agent"
    t.string   "ip"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canary_id"], name: "index_checkins_on_canary_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
    t.index ["team_id", "user_id"], name: "index_teams_users_on_team_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "team_id"], name: "index_teams_users_on_user_id_and_team_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username",                               null: false
    t.boolean  "admin",                  default: false
    t.string   "api_key"
    t.index ["api_key"], name: "index_users_on_api_key", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

  add_foreign_key "alert_integrations", "teams"
  add_foreign_key "alerts", "canaries"
  add_foreign_key "canaries", "teams"
  add_foreign_key "canaries", "users", column: "created_by_id"
  add_foreign_key "checkins", "canaries"
end
