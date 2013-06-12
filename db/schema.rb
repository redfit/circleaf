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

ActiveRecord::Schema.define(version: 20130606070911) do

  create_table "connections", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "name",         null: false
    t.string   "image"
    t.string   "access_token", null: false
    t.string   "secret_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["provider", "uid"], name: "index_connections_on_provider_and_uid", unique: true
  add_index "connections", ["user_id"], name: "index_connections_on_user_id"

  create_table "groups", force: true do |t|
    t.string   "name",                          null: false
    t.text     "content"
    t.string   "scope",      default: "public", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["scope"], name: "index_groups_on_scope"

  create_table "memberships", force: true do |t|
    t.integer  "group_id",                      null: false
    t.integer  "user_id",                       null: false
    t.string   "scope",      default: "member", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id", "user_id"], name: "index_memberships_on_group_id_and_user_id", unique: true

  create_table "posts", force: true do |t|
    t.string   "type"
    t.integer  "group_id",   null: false
    t.integer  "user_id",    null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["group_id"], name: "index_posts_on_group_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "image"
    t.integer  "default_provider_id"
    t.string   "unconfirmed_email"
    t.datetime "confirm_limit_at"
    t.string   "hash_to_confirm_email"
    t.string   "locale"
    t.text     "content"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",         default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
