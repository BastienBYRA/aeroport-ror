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

ActiveRecord::Schema[7.0].define(version: 2023_04_04_150416) do
  create_table "flights", force: :cascade do |t|
    t.integer "number"
    t.string "departure_airport"
    t.string "arrival_airport"
    t.integer "business_class_seats"
    t.integer "economy_class_seats"
    t.datetime "departure_date", precision: nil
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "seat_number"
    t.string "code"
    t.integer "user_id", null: false
    t.integer "flight_id", null: false
    t.integer "seat_class_choice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_reservations_on_flight_id"
    t.index ["seat_class_choice_id"], name: "index_reservations_on_seat_class_choice_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "seat_class_choices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reservations", "flights"
  add_foreign_key "reservations", "seat_class_choices"
  add_foreign_key "reservations", "users"
end
