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

ActiveRecord::Schema.define(version: 20151104061608) do

  create_table "order_items", force: :cascade do |t|
    t.string   "status",     null: false
    t.text     "content"
    t.integer  "order_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.string   "title",                      null: false
    t.decimal  "bounty",                     null: false
    t.datetime "deliver_by"
    t.datetime "accepted_at"
    t.integer  "service_rating", default: 0
    t.string   "status",                     null: false
    t.integer  "owner_id",                   null: false
    t.integer  "servicer_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "orders", ["owner_id"], name: "index_orders_on_owner_id"
  add_index "orders", ["servicer_id"], name: "index_orders_on_servicer_id"

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
  end

end
