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

ActiveRecord::Schema.define(:version => 20110929045826) do

  create_table "comments", :force => true do |t|
    t.string   "description"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_uploads", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "post_types", :force => true do |t|
    t.string   "types"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_types_id"
  end

  create_table "user_comment_statuses", :force => true do |t|
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "comment_id"
  end

  create_table "user_post_statuses", :force => true do |t|
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "post_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "address"
    t.string   "email"
    t.integer  "mobile_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usertype_id"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token",  :default => "", :null => false
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "usertypes", :force => true do |t|
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
