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

ActiveRecord::Schema[7.0].define(version: 2023_12_22_060602) do
  create_table "administrators", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "phone", null: false
    t.integer "sex", default: 1, null: false
    t.date "birthday", default: -> { "CURRENT_DATE" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "required_time"
    t.integer "#<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x0000000108071dc8>"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "phone", null: false
    t.integer "sex", default: 1, null: false
    t.date "birthday", default: -> { "CURRENT_DATE" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.integer "salon_id", null: false
    t.string "name", null: false
    t.string "email"
    t.string "phone", null: false
    t.integer "sex", default: 1, null: false
    t.date "birthday", default: -> { "CURRENT_DATE" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salon_id"], name: "index_owners_on_salon_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "coustomer_id", null: false
    t.date "reserved_date", null: false
    t.integer "reserved_time", null: false
    t.integer "sum_price", null: false
    t.integer "cource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coustomer_id"], name: "index_reservations_on_coustomer_id"
  end

  create_table "salons", force: :cascade do |t|
    t.string "name", null: false
    t.string "prefecture", null: false
    t.string "adress", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.integer "stylist_id", null: false
    t.integer "reservation_id"
    t.datetime "date_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_shifts_on_reservation_id"
    t.index ["stylist_id"], name: "index_shifts_on_stylist_id"
  end

  create_table "stylists", force: :cascade do |t|
    t.integer "salon_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["salon_id"], name: "index_stylists_on_salon_id"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
