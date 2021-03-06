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

ActiveRecord::Schema.define(:version => 20150711213043) do

  create_table "activities", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "idea_id"
    t.string   "action"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "activities", ["idea_id"], :name => "index_activities_on_idea_id"
  add_index "activities", ["project_id"], :name => "index_activities_on_project_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ideas", :force => true do |t|
    t.text     "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "project_id"
    t.integer  "user_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.string  "body_bg"
    t.string  "tag_bg"
    t.string  "tag_color"
    t.string  "link_color"
    t.boolean "email_notify", :default => false
    t.boolean "sms_notify",   :default => false
  end

  add_index "projects_users", ["project_id", "user_id"], :name => "index_projects_users_on_project_id_and_user_id"
  add_index "projects_users", ["user_id", "project_id"], :name => "index_projects_users_on_user_id_and_project_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "phone"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
