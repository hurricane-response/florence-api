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

ActiveRecord::Schema.define(version: 20170831220720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "needs", force: :cascade do |t|
    t.string "updated_by"
    t.string "timestamp"
    t.string "location_name"
    t.string "location_address"
    t.float "longitude"
    t.float "latitude"
    t.string "contact_for_this_location_name"
    t.string "contact_for_this_location_phone_number"
    t.boolean "are_volunteers_needed"
    t.string "tell_us_about_the_volunteer_needs"
    t.boolean "are_supplies_needed"
    t.string "tell_us_about_the_supply_needs"
    t.string "anything_else_you_would_like_to_tell_us"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shelters", force: :cascade do |t|
    t.string "county"
    t.string "shelter"
    t.string "address"
    t.string "city"
    t.string "pets"
    t.string "phone"
    t.boolean "accepting"
    t.string "last_updated"
    t.string "updated_by"
    t.string "notes"
    t.string "volunteer_needs"
    t.float "longitude"
    t.float "latitude"
    t.string "supply_needs"
    t.string "source"
    t.string "address_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
