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

ActiveRecord::Schema.define(version: 20140617194120) do

  create_table "learn_lti_engine_accounts", force: true do |t|
    t.string   "lti_key"
    t.string   "lti_secret"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "learn_lti_engine_assignments", force: true do |t|
    t.integer  "user_id"
    t.string   "type"
    t.text     "lti_launch_params"
    t.text     "completed_tasks"
    t.string   "lti_assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  add_index "learn_lti_engine_assignments", ["user_id"], name: "index_learn_lti_engine_assignments_on_user_id"

  create_table "learn_lti_engine_step_data", force: true do |t|
    t.integer  "assignment_id"
    t.string   "step"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

  add_index "learn_lti_engine_step_data", ["assignment_id"], name: "index_learn_lti_engine_step_data_on_assignment_id"

  create_table "learn_lti_engine_users", force: true do |t|
    t.string   "lti_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
