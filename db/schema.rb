# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141129123713) do

  create_table "management_dissertations", force: true do |t|
    t.integer  "students_id"
    t.integer  "projects_id"
    t.datetime "delivery_date"
    t.datetime "extension_date"
    t.string   "status",         default: "standby"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "management_dissertations", ["students_id", "projects_id"], name: "index_management_dissertations_on_students_id_and_projects_id"
  add_index "management_dissertations", ["students_id"], name: "index_management_dissertations_on_students_id"

  create_table "projects", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.string   "title"
    t.string   "description"
    t.text     "skills_required"
    t.boolean  "completed",       default: false
    t.binary   "attached"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["student_id"], name: "index_projects_on_student_id"
  add_index "projects", ["teacher_id"], name: "index_projects_on_teacher_id"

  create_table "students", force: true do |t|
    t.string   "department"
    t.string   "phone"
    t.string   "am"
    t.string   "email_communication"
    t.boolean  "dissertation_completed", default: false
    t.text     "skills"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id"

  create_table "teachers", force: true do |t|
    t.string   "department"
    t.string   "phone"
    t.string   "grade"
    t.string   "email_communication"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["user_id"], name: "index_teachers_on_user_id"

  create_table "users", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["student_id"], name: "index_users_on_student_id"
  add_index "users", ["teacher_id"], name: "index_users_on_teacher_id"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
