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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130305233156) do

  create_table "exchanges", :force => true do |t|
    t.string   "name"
    t.date     "match_date"
    t.date     "exchange_date"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "organizer_id"
    t.boolean  "matchedup",     :default => false, :null => false
    t.integer  "max_price",     :default => 0,     :null => false
  end

  add_index "exchanges", ["organizer_id"], :name => "index_exchanges_on_organizer_id"

  create_table "gifts", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.string   "picture_url"
    t.string   "category"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "price"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "exchange_id"
    t.string   "invited_email"
    t.string   "token"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "accepted",      :default => false
    t.integer  "sender_id"
  end

  add_index "invitations", ["exchange_id"], :name => "index_invitations_on_exchange_id"
  add_index "invitations", ["invited_email"], :name => "index_invitations_on_invited_email"
  add_index "invitations", ["token"], :name => "index_invitations_on_token"

  create_table "matches", :force => true do |t|
    t.integer  "santa_id"
    t.integer  "recipient_id"
    t.integer  "gift_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "exchange_id"
  end

  add_index "matches", ["exchange_id"], :name => "index_matches_on_exchange_id"
  add_index "matches", ["gift_id"], :name => "index_matches_on_gift_id"
  add_index "matches", ["recipient_id"], :name => "index_matches_on_recipient_id"
  add_index "matches", ["santa_id"], :name => "index_matches_on_santa_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "exchange_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "memberships", ["exchange_id"], :name => "index_memberships_on_exchange_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "associated_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "seen",          :default => false
    t.string   "kind"
  end

  create_table "profiles", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
