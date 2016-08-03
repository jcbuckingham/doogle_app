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

ActiveRecord::Schema.define(version: 20160803174949) do

  create_table "definitions", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "search_result_id"
    t.index ["search_result_id"], name: "index_definitions_on_search_result_id"
  end

  create_table "search_results", force: :cascade do |t|
    t.string   "user_input"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_input"], name: "index_search_results_on_user_input", unique: true
  end

end
