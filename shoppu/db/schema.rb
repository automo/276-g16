# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151201065052) do

  create_table "order_items", force: :cascade do |t|
    t.string   "status",             default: "open", null: false
    t.text     "content",                             null: false
    t.integer  "order_request_id",                    null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "completed_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "order_items", ["order_request_id"], name: "index_order_items_on_order_request_id"

  create_table "order_requests", force: :cascade do |t|
    t.string   "title",                           null: false
    t.decimal  "bounty",                          null: false
    t.datetime "deliver_by"
    t.datetime "accepted_at"
    t.integer  "service_rating", default: 0
    t.string   "status",         default: "open", null: false
    t.integer  "owner_id",                        null: false
    t.integer  "servicer_id"
    t.text     "description"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "order_requests", ["owner_id"], name: "index_order_requests_on_owner_id"
  add_index "order_requests", ["servicer_id"], name: "index_order_requests_on_servicer_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",                              null: false
    t.string   "address",                               null: false
    t.string   "email",                                 null: false
    t.string   "password_digest",                       null: false
    t.date     "birthdate",                             null: false
    t.string   "first_name",                            null: false
    t.string   "last_name",                             null: false
    t.boolean  "is_moderator",          default: false, null: false
    t.integer  "rating",                default: 0,     null: false
    t.integer  "failed_login_attempts", default: 0,     null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["email"], name: "index_users_on_email"

end
