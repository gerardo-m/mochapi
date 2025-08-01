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

ActiveRecord::Schema[8.0].define(version: 2025_07_10_035249) do
  create_table "endpoints", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "path"
    t.string "method"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_endpoints_on_project_id"
  end

  create_table "expressions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "operand1_val"
    t.string "operand1_type"
    t.string "operation"
    t.text "operand2_val"
    t.string "operand2_type"
    t.bigint "conditionable_id"
    t.string "conditionable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conditionable_type", "conditionable_id"], name: "index_expressions_on_conditionable_type_and_conditionable_id"
  end

  create_table "headers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "response_id", null: false
    t.string "field"
    t.string "value"
    t.boolean "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["response_id"], name: "index_headers_on_response_id"
  end

  create_table "m_variables", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "value_type"
    t.integer "integer_value"
    t.decimal "decimal_value", precision: 10
    t.text "text_value"
    t.string "variable_holder_type"
    t.bigint "variable_holder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["variable_holder_type", "variable_holder_id"], name: "index_m_variables_on_variable_holder"
  end

  create_table "plain_responses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "space_name"
    t.string "url_preffix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["space_name"], name: "index_projects_on_space_name", unique: true
  end

  create_table "remembered_values", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "control_attribute"
    t.string "value_attribute"
    t.string "control_attribute_type"
    t.string "value_attribute_type"
    t.string "control_attribute_value"
    t.string "value_attribute_value"
    t.string "value_interchangeable_type"
    t.bigint "value_interchangeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["value_interchangeable_type", "value_interchangeable_id"], name: "idx_on_value_interchangeable_type_value_interchange_50d633ae16"
  end

  create_table "responses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "responseable_type"
    t.integer "responseable_id"
    t.bigint "endpoint_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_number", default: 0
    t.integer "status_code"
    t.index ["endpoint_id"], name: "index_responses_on_endpoint_id"
  end

  add_foreign_key "endpoints", "projects"
  add_foreign_key "headers", "responses"
  add_foreign_key "responses", "endpoints"
end
