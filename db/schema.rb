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

ActiveRecord::Schema.define(version: 20151216205107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string  "choice"
    t.integer "question_id"
    t.boolean "is_correct"
  end

  create_table "cohorts", force: :cascade do |t|
    t.string  "name"
    t.integer "instructor_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
  end

  create_table "questions_quizzes", force: :cascade do |t|
    t.integer "quiz_id"
    t.integer "question_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.date    "test_day"
    t.integer "instructor_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string  "choice"
    t.integer "student_id"
    t.integer "quiz_id"
    t.integer "question_id"
  end

  create_table "students", force: :cascade do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.string  "email"
    t.string  "password_digest"
    t.integer "cohort_id"
  end

end
