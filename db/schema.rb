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

ActiveRecord::Schema.define(version: 20141127153607) do

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.text     "skills_required"
    t.binary   "attached"
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["student_id"], name: "index_projects_on_student_id"
  add_index "projects", ["teacher_id"], name: "index_projects_on_teacher_id"

  create_table "projects_students", id: false, force: true do |t|
    t.integer "project_id"
    t.integer "student_id"
    t.string  "status",     default: "standby"
  end

  add_index "projects_students", ["project_id", "student_id"], name: "index_projects_students_on_project_id_and_student_id"
  add_index "projects_students", ["student_id"], name: "index_projects_students_on_student_id"

  create_table "students", force: true do |t|
    t.string   "department"
    t.string   "phone"
    t.string   "am"
    t.string   "email_communication"
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
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["student_id"], name: "index_users_on_student_id"
  add_index "users", ["teacher_id"], name: "index_users_on_teacher_id"

end
