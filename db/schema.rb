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

ActiveRecord::Schema.define(version: 20160821113539) do

  create_table "authentications", force: :cascade do |t|
    t.string   "email"
    t.string   "uid"
    t.string   "provider"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["uid"], name: "index_authentications_on_uid"
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id"

  create_table "feedbacks", force: :cascade do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "current_controller"
    t.string   "current_action"
    t.text     "current_params"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "feedbacks", ["email"], name: "index_feedbacks_on_email"
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id"

  create_table "mgca_address_translations", force: :cascade do |t|
    t.integer  "mgca_address_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "street_name"
  end

  add_index "mgca_address_translations", ["locale"], name: "index_mgca_address_translations_on_locale"
  add_index "mgca_address_translations", ["mgca_address_id"], name: "index_mgca_address_translations_on_mgca_address_id"

  create_table "mgca_addresses", force: :cascade do |t|
    t.string   "name"
    t.text     "fetch_address"
    t.string   "street_default"
    t.string   "street_number"
    t.string   "street_additional"
    t.integer  "zipcode"
    t.string   "status",            default: "new"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "subdistrict_id"
    t.integer  "district_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "mgca_addresses", ["city_id"], name: "index_mgca_addresses_on_city_id"
  add_index "mgca_addresses", ["country_id"], name: "index_mgca_addresses_on_country_id"
  add_index "mgca_addresses", ["district_id"], name: "index_mgca_addresses_on_district_id"
  add_index "mgca_addresses", ["state_id"], name: "index_mgca_addresses_on_state_id"
  add_index "mgca_addresses", ["subdistrict_id"], name: "index_mgca_addresses_on_subdistrict_id"

  create_table "mgca_addressibles", force: :cascade do |t|
    t.boolean  "default"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mgca_addressibles", ["address_id"], name: "index_mgca_addressibles_on_address_id"
  add_index "mgca_addressibles", ["owner_type", "owner_id"], name: "index_mgca_addressibles_on_owner_type_and_owner_id"

  create_table "mgca_cities", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_cities", ["country_id"], name: "index_mgca_cities_on_country_id"
  add_index "mgca_cities", ["state_id"], name: "index_mgca_cities_on_state_id"

  create_table "mgca_city_translations", force: :cascade do |t|
    t.integer  "mgca_city_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
  end

  add_index "mgca_city_translations", ["locale"], name: "index_mgca_city_translations_on_locale"
  add_index "mgca_city_translations", ["mgca_city_id"], name: "index_mgca_city_translations_on_mgca_city_id"

  create_table "mgca_countries", force: :cascade do |t|
    t.string   "default_name"
    t.string   "iso_code",     limit: 2
    t.string   "dial_code"
    t.string   "fsm_state",              default: "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mgca_country_translations", force: :cascade do |t|
    t.integer  "mgca_country_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
  end

  add_index "mgca_country_translations", ["locale"], name: "index_mgca_country_translations_on_locale"
  add_index "mgca_country_translations", ["mgca_country_id"], name: "index_mgca_country_translations_on_mgca_country_id"

  create_table "mgca_district_translations", force: :cascade do |t|
    t.integer  "mgca_district_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
  end

  add_index "mgca_district_translations", ["locale"], name: "index_mgca_district_translations_on_locale"
  add_index "mgca_district_translations", ["mgca_district_id"], name: "index_mgca_district_translations_on_mgca_district_id"

  create_table "mgca_districts", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_districts", ["city_id"], name: "index_mgca_districts_on_city_id"

  create_table "mgca_state_translations", force: :cascade do |t|
    t.integer  "mgca_state_id", null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
  end

  add_index "mgca_state_translations", ["locale"], name: "index_mgca_state_translations_on_locale"
  add_index "mgca_state_translations", ["mgca_state_id"], name: "index_mgca_state_translations_on_mgca_state_id"

  create_table "mgca_states", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_states", ["country_id"], name: "index_mgca_states_on_country_id"

  create_table "mgca_subdistrict_translations", force: :cascade do |t|
    t.integer  "mgca_subdistrict_id", null: false
    t.string   "locale",              null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
  end

  add_index "mgca_subdistrict_translations", ["locale"], name: "index_mgca_subdistrict_translations_on_locale"
  add_index "mgca_subdistrict_translations", ["mgca_subdistrict_id"], name: "index_mgca_subdistrict_translations_on_mgca_subdistrict_id"

  create_table "mgca_subdistricts", force: :cascade do |t|
    t.string   "default_name"
    t.string   "short_name"
    t.string   "fsm_state",    default: "new"
    t.integer  "district_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgca_subdistricts", ["city_id"], name: "index_mgca_subdistricts_on_city_id"
  add_index "mgca_subdistricts", ["district_id"], name: "index_mgca_subdistricts_on_district_id"

  create_table "mgclang_languages", force: :cascade do |t|
    t.string   "level"
    t.boolean  "default",    default: false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "locale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgclang_languages", ["locale_id"], name: "index_mgclang_languages_on_locale_id"
  add_index "mgclang_languages", ["owner_type", "owner_id"], name: "index_mgclang_languages_on_owner_type_and_owner_id"

  create_table "mgclang_locale_translations", force: :cascade do |t|
    t.integer  "mgclang_locale_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
  end

  add_index "mgclang_locale_translations", ["locale"], name: "index_mgclang_locale_translations_on_locale"
  add_index "mgclang_locale_translations", ["mgclang_locale_id"], name: "index_mgclang_locale_translations_on_mgclang_locale_id"

  create_table "mgclang_locales", force: :cascade do |t|
    t.string   "natural_name"
    t.string   "iso_code"
    t.string   "locale_state", default: "inactive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mgclang_locales", ["iso_code"], name: "index_mgclang_locales_on_iso_code", unique: true

  create_table "questions", force: :cascade do |t|
    t.integer  "position"
    t.text     "text"
    t.string   "answer1"
    t.string   "answer2"
    t.string   "answer3"
    t.integer  "result"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "settings", force: :cascade do |t|
    t.decimal  "blink_time",    default: 10.0
    t.decimal  "stop_time",     default: 3.0
    t.integer  "interval_time", default: 120
    t.integer  "speed_step",    default: 20
    t.integer  "step_time",     default: 1000
    t.string   "step_type",     default: "none"
    t.string   "blink_type",    default: "highlight"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id"

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email"
    t.boolean  "newsletter"
    t.boolean  "dev_news"
    t.integer  "user_id"
    t.string   "user_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["email"], name: "index_subscriptions_on_email"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "gender"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.date     "birthday"
    t.string   "image_uid"
    t.string   "image_name"
    t.string   "image_crop"
    t.boolean  "is_wizard",              default: false
    t.boolean  "is_master_wizard",       default: false
    t.boolean  "tmp_password"
    t.string   "signup_via"
    t.string   "signup_url"
    t.string   "api_auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["api_auth_token"], name: "index_users_on_api_auth_token", unique: true
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["first_name"], name: "index_users_on_first_name"
  add_index "users", ["last_name"], name: "index_users_on_last_name"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
