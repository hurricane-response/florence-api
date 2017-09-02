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

ActiveRecord::Schema.define(version: 20170902140452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amazon_products", force: :cascade do |t|
    t.string "need"
    t.string "amazon_title"
    t.string "asin"
    t.string "detail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "priority", default: false
    t.boolean "disabled", default: false
  end

  create_table "drafts", force: :cascade do |t|
    t.jsonb "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "record_type"
    t.bigint "record_id"
    t.bigint "accepted_by_id"
    t.bigint "denied_by_id"
    t.index ["accepted_by_id"], name: "index_drafts_on_accepted_by_id"
    t.index ["denied_by_id"], name: "index_drafts_on_denied_by_id"
    t.index ["record_type", "record_id"], name: "index_drafts_on_record_type_and_record_id"
  end

  create_table "ignored_amazon_product_needs", force: :cascade do |t|
    t.string "need"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "users", force: :cascade do |t|
    t.boolean "admin"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "drafts", "users", column: "accepted_by_id"
  add_foreign_key "drafts", "users", column: "denied_by_id"
end
