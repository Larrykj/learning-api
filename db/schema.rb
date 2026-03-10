# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_09_123155) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "authors", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "author"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "car_details", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "make"
    t.string "model"
    t.datetime "updated_at", null: false
    t.string "year"
  end

  create_table "car_owners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "car_id", null: false
    t.datetime "created_at", null: false
    t.uuid "owner_id", null: false
    t.datetime "ownership_end_date", precision: nil
    t.datetime "ownership_start_date", precision: nil
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_car_owners_on_car_id"
    t.index ["owner_id"], name: "index_car_owners_on_owner_id"
  end

  create_table "cars", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "make"
    t.text "model"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  create_table "owners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "age"
    t.datetime "created_at", null: false
    t.text "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "books", "authors"
  add_foreign_key "car_owners", "cars"
  add_foreign_key "car_owners", "owners"
end
