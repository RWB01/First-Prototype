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

ActiveRecord::Schema.define(version: 20170521014713) do

  create_table "algorithms", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "theme_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "code_file_name"
    t.string   "code_content_type"
    t.integer  "code_file_size"
    t.datetime "code_updated_at"
    t.index ["theme_id"], name: "index_algorithms_on_theme_id"
  end

  create_table "data_structures", force: :cascade do |t|
    t.string   "alias"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "alias"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.string   "alias"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "disciplines_users", id: false, force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "discipline_id", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "alias"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "next_steps", id: false, force: :cascade do |t|
    t.integer "step_id",      null: false
    t.integer "next_step_id", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "alias"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "step_variables", force: :cascade do |t|
    t.string   "alias"
    t.string   "name"
    t.integer  "step_id"
    t.integer  "data_structure_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "limitation"
    t.index ["data_structure_id"], name: "index_step_variables_on_data_structure_id"
    t.index ["step_id"], name: "index_step_variables_on_step_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "line_number"
    t.string   "description"
    t.integer  "step_number"
    t.integer  "algorithm_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["algorithm_id"], name: "index_steps_on_algorithm_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string   "title"
    t.integer  "discipline_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "alias"
    t.index ["discipline_id"], name: "index_themes_on_discipline_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "community_type"
    t.integer  "community_id"
    t.index ["community_type", "community_id"], name: "index_users_on_community_type_and_community_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "variables", force: :cascade do |t|
    t.string   "alias"
    t.string   "name"
    t.string   "limitation"
    t.integer  "algorithm_id"
    t.integer  "data_structure_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["algorithm_id"], name: "index_variables_on_algorithm_id"
    t.index ["data_structure_id"], name: "index_variables_on_data_structure_id"
  end

end
