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

ActiveRecord::Schema.define(version: 20180727144041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "avatar"
    t.string "background"
    t.integer "main_category_id"
    t.integer "main_country_id"
    t.integer "status", default: 0
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "mode"
    t.integer "format"
    t.integer "target_country_id"
    t.integer "content_language"
    t.integer "currency"
    t.string "name"
    t.integer "input_type"
    t.string "url"
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.integer "linking_id"
    t.string "linking_type"
    t.integer "linked_id"
    t.string "linked_type"
    t.string "external_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media", force: :cascade do |t|
    t.integer "mediable_id"
    t.string "mediable_type"
    t.string "url"
    t.integer "kind", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "picks", force: :cascade do |t|
    t.integer "author_id"
    t.string "author_type"
    t.text "body"
    t.string "main_image"
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "legal_name"
    t.string "description"
    t.string "website"
    t.integer "business_type"
    t.integer "status", default: 0
    t.integer "kyc", default: 0
    t.string "avatar"
    t.string "background"
    t.integer "main_category_id"
    t.integer "main_country_id"
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "registration_number"
    t.integer "phone"
    t.integer "integration_type"
    t.text "payment_rules"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "showrooms", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "description"
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0
    t.string "full_name"
    t.string "username"
    t.integer "phone"
    t.integer "country_id"
    t.integer "city_id"
    t.string "description"
    t.string "avatar"
    t.string "background"
    t.string "instagram"
    t.string "twitch"
    t.string "facebook"
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
