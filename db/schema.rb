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

ActiveRecord::Schema.define(:version => 20140410173329) do

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

  create_table "bank_accounts", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.integer  "bank_account_mangopay_id", :null => false
    t.string   "owner_name",               :null => false
    t.string   "owner_address",            :null => false
    t.string   "iban",                     :null => false
    t.string   "bic",                      :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "bank_accounts", ["user_id", "bank_account_mangopay_id"], :name => "index_on_bank_accounts", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          :default => 0, :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "credit_cards", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.integer  "user_mangopay_id",                :null => false
    t.integer  "card_mangopay_id",                :null => false
    t.string   "card_status",                     :null => false
    t.string   "card_provider",                   :null => false
    t.date     "expiration_date",                 :null => false
    t.integer  "currency_id",      :default => 1, :null => false
    t.string   "card_alias",                      :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "credit_cards", ["user_id", "card_mangopay_id"], :name => "index_on_credit_cards", :unique => true

  create_table "currencies", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "symbol",     :null => false
    t.string   "code",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "currencies", ["code"], :name => "index_currencies_on_code", :unique => true
  add_index "currencies", ["symbol"], :name => "index_currencies_on_symbol", :unique => true
  add_index "currencies", ["title"], :name => "index_currencies_on_title", :unique => true

  create_table "entities", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "entities", ["title"], :name => "index_entities_on_title", :unique => true

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

  create_table "flag_comments", :force => true do |t|
    t.integer  "comment_id", :null => false
    t.integer  "admin_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "flag_comments", ["comment_id"], :name => "index_flag_comments_on_comment_id", :unique => true

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

  create_table "page_views", :force => true do |t|
    t.integer  "element_id",                  :null => false
    t.string   "element_type",                :null => false
    t.integer  "viewed",       :default => 1
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "page_views", ["element_type", "element_id"], :name => "PageViewsIndex", :unique => true

  create_table "place_type_associations", :force => true do |t|
    t.integer  "place_id",      :null => false
    t.integer  "place_type_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "place_type_associations", ["place_id", "place_type_id"], :name => "index_place_type_associations_on_place_id_and_place_type_id", :unique => true

  create_table "place_types", :force => true do |t|
    t.string   "title",               :null => false
    t.text     "description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "marker_file_name"
    t.string   "marker_content_type"
    t.integer  "marker_file_size"
    t.datetime "marker_updated_at"
    t.integer  "user_id"
  end

  add_index "place_types", ["title"], :name => "index_place_types_on_title", :unique => true

  create_table "places", :force => true do |t|
    t.string   "title",                :null => false
    t.text     "description"
    t.string   "google_id"
    t.float    "longitude",            :null => false
    t.float    "latitude",             :null => false
    t.string   "addr",                 :null => false
    t.string   "city"
    t.string   "zip_code"
    t.string   "country"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
  end

  create_table "products", :force => true do |t|
    t.integer  "user_id",                             :null => false
    t.string   "title",                               :null => false
    t.text     "description"
    t.float    "price",                               :null => false
    t.integer  "currency_id",          :default => 1, :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "products", ["user_id", "title"], :name => "products_index", :unique => true

  create_table "project_pictures", :force => true do |t|
    t.integer  "project_id",         :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "title",       :null => false
    t.integer  "user_id",     :null => false
    t.text     "description", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "projects", ["title"], :name => "index_projects_on_title", :unique => true

  create_table "question_types", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "question_types", ["title"], :name => "index_question_types_on_title", :unique => true

  create_table "questions", :force => true do |t|
    t.string   "title",                           :null => false
    t.text     "answer",                          :null => false
    t.integer  "user_id",                         :null => false
    t.string   "locale",                          :null => false
    t.integer  "display_order",    :default => 1
    t.integer  "question_type_id",                :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "questions", ["title"], :name => "index_questions_on_title", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "value",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "settings", ["title"], :name => "index_settings_on_title", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], :name => "taggings_idx", :unique => true

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "currency_id",            :default => 1,     :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], :name => "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], :name => "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

  create_table "wallets", :force => true do |t|
    t.integer  "user_id",                             :null => false
    t.integer  "wallet_mangopay_id",                  :null => false
    t.float    "balance",            :default => 0.0, :null => false
    t.integer  "currency_id",        :default => 1,   :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "wallets", ["user_id", "wallet_mangopay_id"], :name => "wallet_index", :unique => true

end
