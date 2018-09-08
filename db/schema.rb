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

ActiveRecord::Schema.define(version: 20180907134757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "shop_id"
    t.float "balance", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_accounts_on_shop_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

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
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "author_id"
    t.string "author_type"
    t.integer "status", default: 0
    t.string "name"
    t.integer "country_id"
    t.integer "kind", default: 0
    t.boolean "link_referral"
    t.string "link_1"
    t.string "link_2"
    t.string "link_3"
    t.string "link_4"
    t.string "link_5"
    t.float "points_per_referral", default: 0.0
    t.boolean "product_tagging"
    t.float "points_per_tag", default: 0.0
    t.integer "campaign_products", default: 0
    t.string "label_1"
    t.string "label_2"
    t.string "label_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "google_category_id"
    t.integer "parent_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clicks", force: :cascade do |t|
    t.integer "clicker_id"
    t.integer "winner_id"
    t.integer "pick_id"
    t.integer "product_id"
    t.string "link"
    t.integer "status", default: 0
    t.datetime "trigger_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "country_shops", force: :cascade do |t|
    t.bigint "shop_id"
    t.bigint "country_id"
    t.integer "mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_shops_on_country_id"
    t.index ["shop_id"], name: "index_country_shops_on_shop_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.bigint "shop_id"
    t.bigint "country_id"
    t.bigint "currency_id"
    t.integer "kind"
    t.integer "discount_mode"
    t.integer "discount"
    t.integer "discount_products"
    t.integer "additional_info"
    t.integer "coupon_use"
    t.text "instruction"
    t.string "background"
    t.float "points_per_coupon"
    t.string "secret"
    t.integer "number_of_coupons"
    t.integer "number"
    t.integer "parent_id"
    t.integer "status", default: 0
    t.integer "buyer_id"
    t.integer "purchased_at"
    t.integer "utilized_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_coupons_on_country_id"
    t.index ["currency_id"], name: "index_coupons_on_currency_id"
    t.index ["shop_id"], name: "index_coupons_on_shop_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.decimal "usd_rate", precision: 5, scale: 3, default: "0.0"
    t.decimal "ruble_rate", precision: 5, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "name"
    t.bigint "shop_id"
    t.bigint "country_id"
    t.integer "mode", default: 0
    t.integer "currency_id"
    t.boolean "weekends_delivery"
    t.boolean "holidays_delivery"
    t.boolean "pickup"
    t.integer "days_from", default: 0
    t.integer "days_to", default: 1
    t.datetime "timezone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_deliveries_on_country_id"
    t.index ["shop_id"], name: "index_deliveries_on_shop_id"
  end

  create_table "employments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "shop_id"
    t.text "comment"
    t.integer "role", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_employments_on_shop_id"
    t.index ["user_id"], name: "index_employments_on_user_id"
  end

  create_table "feed_campaigns", force: :cascade do |t|
    t.bigint "feed_id"
    t.bigint "campaign_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_feed_campaigns_on_campaign_id"
    t.index ["feed_id"], name: "index_feed_campaigns_on_feed_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "delivery_id"
    t.integer "mode"
    t.integer "format"
    t.integer "kind"
    t.integer "country_id"
    t.integer "currency_id"
    t.string "name"
    t.string "url"
    t.boolean "gift_mode"
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gifts", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "feed_id"
    t.bigint "shop_id"
    t.bigint "country_id"
    t.string "product_type"
    t.integer "main_category_id"
    t.integer "custom_id"
    t.string "brand"
    t.integer "brand_id"
    t.string "title"
    t.text "description"
    t.string "main_image_link"
    t.string "image_link_0"
    t.string "image_link_1"
    t.string "image_link_2"
    t.string "image_link_3"
    t.string "image_link_4"
    t.text "secret"
    t.text "comment"
    t.bigint "points_per_gift", default: 1
    t.integer "number_of_gifts"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_gifts_on_country_id"
    t.index ["shop_id"], name: "index_gifts_on_shop_id"
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.integer "author_id"
    t.string "author_type"
    t.integer "linking_id"
    t.string "linking_type"
    t.integer "linked_id"
    t.string "linked_type"
    t.bigint "medium_id"
    t.bigint "x"
    t.bigint "y"
    t.string "external_link"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medium_id"], name: "index_links_on_medium_id"
  end

  create_table "media", force: :cascade do |t|
    t.integer "mediable_id"
    t.string "mediable_type"
    t.string "url"
    t.integer "kind", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "transaction_id"
    t.integer "ordered_id"
    t.string "ordered_type"
    t.bigint "shop_id"
    t.bigint "user_id"
    t.integer "status"
    t.integer "kind"
    t.float "amount"
    t.datetime "confirmed_at"
    t.datetime "cancelled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_orders_on_shop_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "picks", force: :cascade do |t|
    t.integer "author_id"
    t.string "author_type"
    t.text "body"
    t.string "main_image"
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_coupons", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_product_coupons_on_coupon_id"
    t.index ["product_id"], name: "index_product_coupons_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "feed_id"
    t.integer "country_id"
    t.integer "shop_id"
    t.integer "custom_id"
    t.integer "status", default: 0
    t.integer "item_id"
    t.integer "model_id"
    t.string "venue"
    t.integer "venue_id"
    t.string "brand_name"
    t.integer "brand_id"
    t.string "title"
    t.text "description"
    t.string "link"
    t.string "main_image_link"
    t.string "image_link_0"
    t.string "image_link_1"
    t.string "image_link_2"
    t.string "image_link_3"
    t.string "image_link_4"
    t.string "image_link_5"
    t.string "image_link_6"
    t.string "image_link_7"
    t.string "image_link_8"
    t.string "image_link_9"
    t.float "price", default: 0.0
    t.float "sale_price", default: 0.0
    t.datetime "sale_price_effective_date"
    t.float "point_price", default: 0.0
    t.string "availability"
    t.datetime "availability_date"
    t.datetime "expiration_date"
    t.decimal "cost_of_goods_sold"
    t.string "unit_pricing_measure"
    t.string "unit_pricing_base_measure"
    t.text "installment"
    t.string "loyalty_points"
    t.integer "main_category_id"
    t.string "product_type"
    t.integer "gtin"
    t.string "mpn"
    t.boolean "identifier_exists"
    t.string "condition"
    t.boolean "adult"
    t.integer "multipack"
    t.boolean "is_bundle"
    t.string "energy_efficiency_class"
    t.string "min_energy_efficiency_class"
    t.string "max_energy_efficiency_class"
    t.string "age_group"
    t.string "color"
    t.string "gender"
    t.string "material"
    t.string "pattern"
    t.string "size"
    t.string "size_system"
    t.string "item_group_id"
    t.string "custom_label_0"
    t.string "custom_label_1"
    t.string "shipping"
    t.string "shipping_label"
    t.string "shipping_weight"
    t.string "shipping_length"
    t.string "shipping_width"
    t.string "shipping_height"
    t.integer "max_handling_time"
    t.integer "min_handling_time"
    t.string "tax"
    t.string "tax_category"
    t.string "production_country"
    t.integer "barcode"
    t.string "campaign_label"
    t.boolean "gift_mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.string "follower_type"
    t.integer "followed_id"
    t.string "followed_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "shop_id"
    t.bigint "country_id"
    t.boolean "product_reward"
    t.float "point_to_usd", default: 0.0
    t.float "point_to_lcy", default: 0.0
    t.bigint "currency_id"
    t.integer "fullfilment_mode"
    t.integer "available_products"
    t.integer "delivery_mode"
    t.integer "gift_delivery_id"
    t.boolean "surf_voucher_generation"
    t.integer "voucher_use"
    t.text "voucher_instruction"
    t.boolean "bonus_exchange"
    t.float "point_to_bonus", default: 0.0
    t.integer "bonus_min_time"
    t.integer "bonus_max_time"
    t.integer "gift_min_time"
    t.integer "gift_max_time"
    t.text "no_card_instruction"
    t.text "other_instruction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_rewards_on_country_id"
    t.index ["currency_id"], name: "index_rewards_on_currency_id"
    t.index ["shop_id"], name: "index_rewards_on_shop_id"
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
    t.integer "main_currency_id"
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "brand_id"
    t.integer "registration_number"
    t.string "phone"
    t.string "customer_email"
    t.string "order_email"
    t.integer "integration_type", default: 0
    t.text "payment_rules"
    t.boolean "accepted_rules", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["legal_name"], name: "index_shops_on_legal_name", unique: true
    t.index ["name"], name: "index_shops_on_name", unique: true
    t.index ["registration_number"], name: "index_shops_on_registration_number", unique: true
    t.index ["website"], name: "index_shops_on_website", unique: true
  end

  create_table "showrooms", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "description"
    t.decimal "mana", precision: 5, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "swaps", force: :cascade do |t|
    t.bigint "user_id"
    t.float "points"
    t.float "bonuses"
    t.bigint "shop_id"
    t.integer "status"
    t.bigint "card_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_swaps_on_shop_id"
    t.index ["user_id"], name: "index_swaps_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "tagger_id"
    t.string "tagger_type"
    t.integer "tagged_id"
    t.string "tagged_type"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tariffs", force: :cascade do |t|
    t.bigint "delivery_id"
    t.string "name"
    t.integer "mode", default: 0
    t.integer "kind", default: 0
    t.integer "product_price_from"
    t.integer "product_price_to"
    t.integer "weight_from"
    t.integer "weight_to"
    t.integer "unit", default: 0
    t.decimal "price", precision: 5, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_id"], name: "index_tariffs_on_delivery_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "order_id_id"
    t.integer "purchased_id"
    t.string "purchased_type"
    t.float "amount", default: 0.0
    t.integer "status", default: 0
    t.integer "kind", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["order_id_id"], name: "index_transactions_on_order_id_id"
  end

  create_table "user_campaigns", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "campaign_id"
    t.bigint "link_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_user_campaigns_on_campaign_id"
    t.index ["link_id"], name: "index_user_campaigns_on_link_id"
    t.index ["user_id"], name: "index_user_campaigns_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0
    t.string "full_name"
    t.string "username"
    t.bigint "phone"
    t.integer "country_id"
    t.integer "sex", default: 0
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
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "accounts", "shops"
  add_foreign_key "accounts", "users"
  add_foreign_key "country_shops", "countries"
  add_foreign_key "country_shops", "shops"
  add_foreign_key "coupons", "countries"
  add_foreign_key "coupons", "currencies"
  add_foreign_key "coupons", "shops"
  add_foreign_key "deliveries", "countries"
  add_foreign_key "deliveries", "shops"
  add_foreign_key "employments", "shops"
  add_foreign_key "employments", "users"
  add_foreign_key "feed_campaigns", "campaigns"
  add_foreign_key "feed_campaigns", "feeds"
  add_foreign_key "gifts", "countries"
  add_foreign_key "gifts", "shops"
  add_foreign_key "links", "media"
  add_foreign_key "orders", "shops"
  add_foreign_key "orders", "users"
  add_foreign_key "product_coupons", "coupons"
  add_foreign_key "product_coupons", "products"
  add_foreign_key "rewards", "countries"
  add_foreign_key "rewards", "currencies"
  add_foreign_key "rewards", "shops"
  add_foreign_key "swaps", "shops"
  add_foreign_key "swaps", "users"
  add_foreign_key "tariffs", "deliveries"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "user_campaigns", "campaigns"
  add_foreign_key "user_campaigns", "links"
  add_foreign_key "user_campaigns", "users"
end
