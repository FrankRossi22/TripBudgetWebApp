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

ActiveRecord::Schema[8.0].define(version: 2025_04_18_160025) do
  create_table "expense_assignments", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "expense_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_assignments_on_expense_id"
    t.index ["person_id"], name: "index_expense_assignments_on_person_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.float "Amount"
    t.string "People"
    t.integer "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.integer "paid_by_id", null: false
    t.date "date"
    t.string "category"
    t.string "currency"
    t.index ["paid_by_id"], name: "index_expenses_on_paid_by_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_participations_on_person_id"
    t.index ["trip_id"], name: "index_participations_on_trip_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true
  end

  create_table "trip_expenses", force: :cascade do |t|
    t.integer "trip_id", null: false
    t.integer "expense_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_trip_expenses_on_expense_id"
    t.index ["trip_id"], name: "index_trip_expenses_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.date "Start_Date"
    t.date "End_Date"
    t.string "People"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "destination"
  end

  add_foreign_key "expense_assignments", "expenses"
  add_foreign_key "expense_assignments", "people"
  add_foreign_key "expenses", "people", column: "paid_by_id"
  add_foreign_key "participations", "people"
  add_foreign_key "participations", "trips"
  add_foreign_key "trip_expenses", "expenses"
  add_foreign_key "trip_expenses", "trips"
end
