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

ActiveRecord::Schema.define(:version => 20140113165748) do

  create_table "admin_one_shot_codes", :force => true do |t|
    t.integer  "admin_id",   :null => false
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "admin_one_shot_codes", ["admin_id"], :name => "index_admin_one_shot_codes_on_admin_id", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_individual_associations", :force => true do |t|
    t.integer  "event_id",           :null => false
    t.integer  "individual_type_id", :null => false
    t.integer  "individual_id",      :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "event_individual_associations", ["event_id", "individual_type_id", "individual_id"], :name => "index_on_events_assoc", :unique => true

  create_table "events", :force => true do |t|
    t.string   "edition_year", :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "location"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "events", ["edition_year"], :name => "index_events_on_edition_year", :unique => true

  create_table "individual_type_associations", :force => true do |t|
    t.integer  "individual_id",      :null => false
    t.integer  "individual_type_id", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "individual_type_associations", ["individual_id", "individual_type_id"], :name => "index_on_individual_type_association", :unique => true

  create_table "individual_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "individual_types", ["title"], :name => "index_individual_types_on_title", :unique => true

  create_table "individuals", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "twitter_account"
    t.string   "company_name"
    t.text     "description"
    t.date     "birthday"
    t.string   "email"
    t.string   "function"
    t.string   "url"
    t.integer  "individual_type_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "slug"
    t.integer  "display_order",           :default => 9999
  end

  add_index "individuals", ["slug"], :name => "index_individuals_on_slug", :unique => true

  create_table "newsletter_subscribers", :force => true do |t|
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "newsletter_subscribers", ["email"], :name => "index_newsletter_subscribers_on_email", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "value",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "settings", ["title"], :name => "index_settings_on_title", :unique => true

  create_table "translations", :force => true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin",               :default => false
    t.string   "slug"
    t.string   "authentication_token"
    t.string   "facebook_url"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "gender"
    t.string   "description"
    t.date     "birthday_date"
    t.string   "current_language"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
