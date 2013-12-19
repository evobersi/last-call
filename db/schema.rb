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

ActiveRecord::Schema.define(version: 20131219021239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "saved_product", force: true do |t|
    t.integer "search_id",                 null: false
    t.integer "user_id",                   null: false
    t.boolean "added",     default: false
  end

  create_table "searches", force: true do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "retailer_name"
    t.string   "url"
    t.text     "description"
    t.float    "retail_price"
    t.float    "sale_price"
    t.string   "image"
    t.string   "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "added",         default: false
  end

  create_table "users", force: true do |t|
    t.string   "name",             null: false
    t.string   "email",            null: false
    t.string   "phone"
    t.string   "gender"
    t.string   "facebook"
    t.string   "password_digest"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
