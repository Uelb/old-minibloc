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

ActiveRecord::Schema.define(version: 20140307161242) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "client_phones", force: true do |t|
    t.integer  "client_id"
    t.integer  "phone_id"
    t.boolean  "available",  default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_phones", ["client_id"], name: "index_client_phones_on_client_id"
  add_index "client_phones", ["phone_id"], name: "index_client_phones_on_phone_id"

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
    t.string   "api_key"
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
    t.string   "token",           null: false
    t.datetime "last_ping_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.string   "activation_code"
  end

  add_index "phones", ["client_id"], name: "index_phones_on_client_id"
  add_index "phones", ["token"], name: "index_phones_on_token", unique: true

  create_table "statuses", force: true do |t|
    t.string "description"
  end

end
