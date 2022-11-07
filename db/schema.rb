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

ActiveRecord::Schema[7.0].define(version: 2022_11_04_064540) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "availabilities", force: :cascade do |t|
    t.datetime "date"
    t.integer "weekday"
    t.decimal "from", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "to", precision: 8, scale: 2, default: "0.0", null: false
    t.boolean "available", default: true, null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_availabilities_on_date"
    t.index ["from"], name: "index_availabilities_on_from"
    t.index ["teacher_id"], name: "index_availabilities_on_teacher_id"
    t.index ["to"], name: "index_availabilities_on_to"
    t.index ["weekday"], name: "index_availabilities_on_weekday"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.string "slug", limit: 225, null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_courses_on_slug", unique: true
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.datetime "scheduled_at", null: false
    t.bigint "student_id", null: false
    t.bigint "lecture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lecture_id"], name: "index_enrollments_on_lecture_id"
    t.index ["scheduled_at"], name: "index_enrollments_on_scheduled_at", order: :desc
    t.index ["slug"], name: "index_enrollments_on_slug", unique: true
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ends_at"], name: "index_lectures_on_ends_at", order: :desc
    t.index ["lesson_id"], name: "index_lectures_on_lesson_id"
    t.index ["slug"], name: "index_lectures_on_slug", unique: true
    t.index ["starts_at"], name: "index_lectures_on_starts_at", order: :desc
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.string "slug", limit: 255, null: false
    t.integer "minimum_students", default: 1, null: false
    t.integer "maximum_students", default: 3, null: false
    t.decimal "duration", precision: 8, scale: 2, default: "0.0", null: false
    t.bigint "course_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["slug"], name: "index_lessons_on_slug", unique: true
    t.index ["teacher_id"], name: "index_lessons_on_teacher_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 128, null: false
    t.string "last_name", limit: 128, null: false
    t.string "email", limit: 128, null: false
    t.string "password_digest", limit: 128, null: false
    t.string "confirmation_token", limit: 128, null: false
    t.string "password_reset_token", limit: 128
    t.datetime "confirmed_at"
    t.datetime "password_reset_token_sent_at"
    t.datetime "confirmation_token_sent_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.jsonb "preferences", default: {}, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.boolean "terms_of_service", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true
    t.index ["preferences"], name: "index_users_on_preferences", using: :gin
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "availabilities", "users", column: "teacher_id"
  add_foreign_key "courses", "users", column: "teacher_id"
  add_foreign_key "enrollments", "lectures"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "lectures", "lessons"
  add_foreign_key "lessons", "courses"
  add_foreign_key "lessons", "users", column: "teacher_id"
end
