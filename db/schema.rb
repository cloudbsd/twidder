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

ActiveRecord::Schema.define(:version => 20120516143402) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "following_items", :force => true do |t|
    t.integer  "follower_id", :null => false
    t.integer  "followee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "following_items", ["followee_id"], :name => "index_following_items_on_followee_id"
  add_index "following_items", ["follower_id", "followee_id"], :name => "index_following_items_on_follower_id_and_followee_id", :unique => true
  add_index "following_items", ["follower_id"], :name => "index_following_items_on_follower_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "group_id", :null => false
  end

  add_index "groups_users", ["group_id"], :name => "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id", "group_id"], :name => "index_groups_users_on_user_id_and_group_id", :unique => true
  add_index "groups_users", ["user_id"], :name => "index_groups_users_on_user_id"

  create_table "microgroups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "owner_id"
    t.integer  "group_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "microgroups", ["group_id"], :name => "index_microgroups_on_group_id"
  add_index "microgroups", ["owner_id"], :name => "index_microgroups_on_owner_id"

  create_table "microposts", :force => true do |t|
    t.text     "content",    :null => false
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["group_id"], :name => "index_microposts_on_group_id"
  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "path"
    t.string   "gravatar"
    t.integer  "owner_id"
    t.integer  "group_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "projects", ["group_id"], :name => "index_projects_on_group_id"
  add_index "projects", ["owner_id"], :name => "index_projects_on_owner_id"

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.string   "file"
    t.integer  "line"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reviews", ["project_id", "file", "line"], :name => "index_reviews_on_project_id_and_file_and_line"
  add_index "reviews", ["project_id"], :name => "index_reviews_on_project_id"
  add_index "reviews", ["user_id", "project_id"], :name => "index_reviews_on_user_id_and_project_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

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
    t.string   "name",                   :default => "", :null => false
    t.string   "nickname",               :default => "", :null => false
    t.string   "gravatar"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "point"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "votes", ["review_id"], :name => "index_votes_on_review_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
