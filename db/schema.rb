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

ActiveRecord::Schema.define(version: 2021_05_21_051044) do

  create_table "payment_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "working_month", null: false
    t.integer "payment_amount"
    t.date "payment_on"
    t.string "payment_note_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_payment_results_on_user_id"
  end

  create_table "project_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "project_category_name", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_categories_on_project_id"
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "project_name", null: false
    t.integer "project_status", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bank_name"
    t.string "bank_branch_name"
    t.integer "bank_branch_code"
    t.integer "bank_account_type", default: 0
    t.integer "bank_account_code"
    t.string "bank_account_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_user_accounts_on_user_id"
  end

  create_table "user_in_charges", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "user_wage", null: false
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_user_in_charges_on_project_id"
    t.index ["user_id"], name: "index_user_in_charges_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "work_results", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "working_on", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.float "working_hours", default: 0.0
    t.text "working_content"
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "project_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_category_id"], name: "index_work_results_on_project_category_id"
    t.index ["project_id"], name: "index_work_results_on_project_id"
    t.index ["user_id"], name: "index_work_results_on_user_id"
  end

  add_foreign_key "payment_results", "users"
  add_foreign_key "project_categories", "projects"
  add_foreign_key "user_accounts", "users"
  add_foreign_key "user_in_charges", "projects"
  add_foreign_key "user_in_charges", "users"
  add_foreign_key "work_results", "project_categories"
  add_foreign_key "work_results", "projects"
  add_foreign_key "work_results", "users"
end
