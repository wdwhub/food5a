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

ActiveRecord::Schema.define(version: 20160720234353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

end
