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

ActiveRecord::Schema.define(version: 20140226171647) do

  create_table "clients", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "api_key",                             null: false
    t.string   "name",                                null: false
    t.string   "event_base_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["api_key"], name: "index_clients_on_api_key", unique: true
  add_index "clients", ["email"], name: "index_clients_on_email", unique: true
  add_index "clients", ["name"], name: "index_clients_on_name", unique: true
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true

  create_table "messages", force: true do |t|
    t.string   "recipient",       null: false
    t.text     "body",            null: false
    t.datetime "sent_at"
    t.datetime "retrieved_at"
    t.string   "sender"
    t.integer  "client_id"
    t.integer  "main_message_id"
    t.integer  "status_id"
    t.integer  "phone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", force: true do |t|
    t.string   "number"
    t.string   "token",          null: false
    t.datetime "last_ping_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["token"], name: "index_phones_on_token", unique: true

  create_table "statuses", force: true do |t|
    t.string "description"
  end

end
