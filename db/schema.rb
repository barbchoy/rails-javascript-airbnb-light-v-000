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

ActiveRecord::Schema.define(version: 2019_04_10_025105) do

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.integer "price_per_night"
    t.string "city"
    t.integer "max_guests"
    t.boolean "pets_allowed"
    t.text "description"
    t.text "amenities"
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_houses_on_owner_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "title"
    t.integer "cleanliness_rating"
    t.integer "location_rating"
    t.integer "value_rating"
    t.text "comments"
    t.integer "house_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stays", force: :cascade do |t|
    t.integer "guest_id"
    t.integer "house_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "email"
    t.string "image"
    t.string "uid"
    t.integer "balance", default: 0
    t.integer "guests", default: 0
    t.boolean "pets", default: false
    t.boolean "owner", default: false
  end

end
