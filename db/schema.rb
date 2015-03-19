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

ActiveRecord::Schema.define(version: 20150319063800) do

  create_table "project_assignments", force: true do |t|
    t.integer "project_id"
    t.integer "student_id"
    t.boolean "given",      default: false, null: false
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "skills_required"
    t.string   "status",             default: "pending"
    t.binary   "attached"
    t.string   "keywords"
    t.datetime "start_date"
    t.datetime "completion_date"
    t.boolean  "prolongation",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teacher_id"
    t.string   "professor_comments"
  end

  add_index "projects", ["teacher_id"], name: "index_projects_on_teacher_id", using: :btree

  create_table "students", force: true do |t|
    t.integer  "user_id"
    t.string   "department"
    t.string   "phone"
    t.string   "am"
    t.string   "email_communication"
    t.boolean  "dissertation_completed", default: false
    t.text     "skills"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["user_id"], name: "index_students_on_user_id", using: :btree

  create_table "teachers", force: true do |t|
    t.integer  "user_id"
    t.string   "department"
    t.string   "phone"
    t.string   "grade"
    t.string   "email_communication"
    t.text     "descriptions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dissertation_number"
  end

  add_index "teachers", ["user_id"], name: "index_teachers_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "businessCategory"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
