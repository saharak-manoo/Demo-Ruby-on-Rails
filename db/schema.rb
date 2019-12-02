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

ActiveRecord::Schema.define(version: 20190610032110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "class_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "register_courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "subject_id"
    t.bigint "student_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_register_courses_on_deleted_at"
    t.index ["student_id"], name: "index_register_courses_on_student_id"
    t.index ["subject_id"], name: "index_register_courses_on_subject_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "class_level_id"
    t.integer "credits_earned", default: 10
    t.integer "total_vacation", default: 7
    t.index ["class_level_id"], name: "index_students_on_class_level_id"
    t.index ["deleted_at"], name: "index_students_on_deleted_at"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "credit"
    t.string "subject_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vacations", force: :cascade do |t|
    t.string "detail"
    t.string "leave_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.index ["student_id"], name: "index_vacations_on_student_id"
  end

  add_foreign_key "register_courses", "students"
  add_foreign_key "register_courses", "subjects"
  add_foreign_key "students", "class_levels"
  add_foreign_key "vacations", "students"
end
