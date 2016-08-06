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

ActiveRecord::Schema.define(version: 20160806145008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cached_photos", force: :cascade do |t|
    t.integer  "height"
    t.integer  "created_at_by_epoch"
    t.integer  "width"
    t.integer  "foursquare_venue_id"
    t.string   "prefix"
    t.string   "suffix"
    t.string   "fousquare_user"
    t.string   "visibility"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "foursquare_photo_id"
  end

  create_table "cached_tips", force: :cascade do |t|
    t.string   "foursquare_tip_id"
    t.text     "text"
    t.string   "kind"
    t.string   "canonical_url"
    t.string   "lang"
    t.string   "likes_count"
    t.string   "log_view"
    t.string   "agree_count"
    t.integer  "foursquare_user_id"
    t.string   "foursquare_user_first_name"
    t.string   "foursquare_last_name"
    t.string   "foursquare_user_gender"
    t.string   "foursquare_user_photo_prefix"
    t.string   "foursquare_user_photo_suffix"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "foursquare_venue_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "dfb_articles", force: :cascade do |t|
    t.string   "title"
    t.text     "link"
    t.integer  "dfb_eatery_id"
    t.integer  "venue_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["dfb_eatery_id"], name: "index_dfb_articles_on_dfb_eatery_id", using: :btree
    t.index ["venue_id"], name: "index_dfb_articles_on_venue_id", using: :btree
  end

  create_table "dfb_eateries", force: :cascade do |t|
    t.string   "name"
    t.text     "permalink"
    t.text     "description"
    t.string   "service"
    t.string   "type_of_food"
    t.string   "location"
    t.string   "tables_in_wonderland"
    t.text     "reviewlinks"
    t.text     "important_info"
    t.string   "you_might_also_like"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.boolean  "is_park"
    t.string   "credit"
    t.string   "photo_url"
    t.string   "flickr_search_term"
    t.datetime "published_at"
    t.string   "wdw_uri"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "foursquare_eateries", force: :cascade do |t|
    t.string   "name"
    t.integer  "venue_id"
    t.string   "address"
    t.string   "cross_street"
    t.string   "lat"
    t.string   "lng"
    t.string   "alt_venues"
    t.string   "searched_for"
    t.datetime "archived_at"
    t.text     "categories"
    t.string   "referral_id"
    t.text     "location"
    t.text     "canonical_url"
    t.boolean  "verified"
    t.boolean  "dislike"
    t.boolean  "ok"
    t.decimal  "rating",              precision: 10, scale: 2
    t.decimal  "decimal",             precision: 10, scale: 2
    t.string   "rating_color"
    t.string   "rating_signals"
    t.boolean  "allow_menu_url_edit"
    t.string   "specials"
    t.text     "wdw_uri"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "foursquare_id"
    t.index ["venue_id"], name: "index_foursquare_eateries_on_venue_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "height"
    t.integer  "created_at_by_epoch"
    t.integer  "width"
    t.integer  "foursquare_venue_id"
    t.string   "prefix"
    t.string   "suffix"
    t.string   "fousquare_user"
    t.string   "visibility"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "foursquare_photo_id"
  end

  create_table "touring_plans_eateries", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "category_code"
    t.string   "portion_size"
    t.string   "cost_code"
    t.string   "cuisine"
    t.string   "phone_number"
    t.string   "entree_range"
    t.string   "when_to_go"
    t.string   "parking"
    t.string   "bar"
    t.string   "wine_list"
    t.string   "dress"
    t.string   "awards"
    t.string   "breakfast_hours"
    t.string   "lunch_hours"
    t.string   "dinner_hours"
    t.string   "house_specialties"
    t.string   "counter_quality_rating"
    t.string   "counter_value_rating"
    t.float    "table_quality_rating"
    t.float    "table_value_rating"
    t.float    "overall_rating"
    t.float    "service_rating"
    t.float    "friendliness_rating"
    t.integer  "thumbs_up"
    t.string   "adult_breakfast_menu_url"
    t.string   "adult_lunch_menu_url"
    t.string   "adult_dinner_menu_url"
    t.string   "child_breakfast_menu_url"
    t.string   "child_lunch_menu_url"
    t.string   "child_dinner_menu_url"
    t.boolean  "requires_credit_card"
    t.boolean  "requires_pre_payment"
    t.datetime "extinct_on"
    t.datetime "opened_on"
    t.string   "disney_permalink"
    t.string   "code"
    t.string   "short_name"
    t.boolean  "accepts_tiw"
    t.boolean  "accepts_reservations"
    t.boolean  "kosher_available"
    t.string   "location_details"
    t.integer  "operator_id"
    t.text     "operator_url"
    t.string   "operator_type"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "dinable_id"
    t.string   "dinable_type"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.text     "permalink"
    t.string   "category_code"
    t.string   "portion_size"
    t.string   "cost_code"
    t.string   "cuisine"
    t.string   "phone_number"
    t.string   "entree_range"
    t.string   "when_to_go"
    t.string   "parking"
    t.string   "bar"
    t.string   "wine_list"
    t.string   "dress"
    t.string   "awards"
    t.string   "breakfast_hours"
    t.string   "lunch_hours"
    t.string   "dinner_hours"
    t.string   "house_specialties"
    t.string   "counter_quality_rating"
    t.string   "counter_value_rating"
    t.float    "table_quality_rating"
    t.float    "table_value_rating"
    t.float    "overall_rating"
    t.float    "service_rating"
    t.float    "friendliness_rating"
    t.integer  "thumbs_up"
    t.string   "adult_breakfast_menu_url"
    t.string   "adult_lunch_menu_url"
    t.string   "adult_dinner_menu_url"
    t.string   "child_breakfast_menu_url"
    t.string   "child_lunch_menu_url"
    t.string   "child_dinner_menu_url"
    t.boolean  "requires_credit_card"
    t.boolean  "requires_pre_payment"
    t.datetime "extinct_on"
    t.datetime "opened_on"
    t.string   "disney_permalink"
    t.string   "code"
    t.string   "short_name"
    t.boolean  "accepts_tiw"
    t.boolean  "accepts_reservations"
    t.boolean  "kosher_available"
    t.string   "location_details"
    t.integer  "operator_id"
    t.text     "operator_url"
    t.string   "operator_type"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "dfb_articles", "dfb_eateries"
  add_foreign_key "dfb_articles", "venues"
  add_foreign_key "foursquare_eateries", "venues"
end
