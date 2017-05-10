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

ActiveRecord::Schema.define(version: 20170510120618) do

  create_table "locations", force: :cascade do |t|
    t.string   "day"
    t.string   "fromAddress"
    t.float    "from_lat"
    t.float    "from_long"
    t.string   "toAddress"
    t.float    "to_lat"
    t.float    "to_long"
    t.string   "time"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "drive_user_id"
    t.integer  "location_id"
    t.string   "request"
    t.boolean  "read"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["drive_user_id"], name: "index_notifications_on_drive_user_id"
    t.index ["location_id"], name: "index_notifications_on_location_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "gender"
    t.string   "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
