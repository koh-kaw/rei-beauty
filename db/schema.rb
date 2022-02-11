# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_11_054813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "buser_profiles", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.text "description"
    t.integer "business_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "business_user_category_relations", force: :cascade do |t|
    t.bigint "business_user_id"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_business_user_category_relations_on_business_user_id"
    t.index ["category_id"], name: "index_business_user_category_relations_on_category_id"
  end

  create_table "business_user_rooms", force: :cascade do |t|
    t.integer "business_user_id"
    t.integer "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "business_user_treatment_areas", force: :cascade do |t|
    t.integer "ward_id"
    t.bigint "business_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_business_user_treatment_areas_on_business_user_id"
  end

  create_table "business_users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "image"
    t.string "name", null: false
    t.string "family_name", null: false
    t.string "first_name", null: false
    t.string "family_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "tel", null: false
    t.string "station"
    t.integer "gender", null: false
    t.boolean "cert", default: false, null: false
    t.date "birth", null: false
    t.string "interval", default: "1:00"
    t.integer "postal_code", null: false
    t.string "prefecture_code", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "other_address"
    t.integer "station_id"
    t.integer "stations"
    t.integer "category_id"
    t.integer "category_certs", default: [], array: true
    t.text "self_introduction", default: "よろしくお願いします！"
    t.integer "ward_id"
    t.string "emergency_name", null: false
    t.string "emergency_contact", null: false
    t.integer "bank_account_number"
    t.string "bank_name"
    t.string "bank_username"
    t.integer "bank_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_business_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_business_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_business_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_business_users_on_unlock_token", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.string "customer_id", null: false
    t.string "token_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.string "message"
    t.integer "business_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "name"
    t.string "kana"
    t.string "formal_name"
    t.string "abbreviation_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "business_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_favorites_on_business_user_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "interview_chats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "business_user_id"
    t.integer "interview_room_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "interview_room_relations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "business_user_id"
    t.integer "interview_room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "interview_rooms", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lines", force: :cascade do |t|
    t.integer "line_id", null: false
    t.integer "company_id"
    t.string "name"
    t.string "kana"
    t.decimal "lat", precision: 9, scale: 6
    t.decimal "lng", precision: 9, scale: 6
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "menus", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "name", null: false
    t.string "place", null: false
    t.string "price", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.text "content", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_menus_on_owner_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.bigint "user_id"
    t.bigint "business_user_id"
    t.text "message", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_messages_on_business_user_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "off_businesses", force: :cascade do |t|
    t.date "off_day"
    t.time "off_time"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "business_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_off_businesses_on_business_user_id"
  end

  create_table "post_category_relations", force: :cascade do |t|
    t.bigint "business_user_id"
    t.bigint "post_id"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_post_category_relations_on_business_user_id"
    t.index ["category_id"], name: "index_post_category_relations_on_category_id"
    t.index ["post_id"], name: "index_post_category_relations_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.integer "category_id", null: false
    t.integer "price", null: false
    t.integer "total_price", null: false
    t.integer "service_fee", null: false
    t.integer "trans_fee", default: 1000, null: false
    t.integer "cancel_price", default: 0, null: false
    t.string "image"
    t.integer "business_user_id"
    t.string "business_user_name"
    t.integer "time", null: false
    t.time "start_time"
    t.time "end_time"
    t.integer "weekday"
    t.integer "tax", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.bigint "business_user_id", null: false
    t.float "score"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_rankings_on_business_user_id"
  end

  create_table "recruits", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.date "day"
    t.date "from_day"
    t.date "to_day"
    t.integer "category_id"
    t.time "start_time"
    t.time "end_time"
    t.integer "from_price"
    t.integer "to_price"
    t.string "area_id"
    t.integer "user_id"
    t.string "user_name"
    t.integer "ward_id", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.date "day"
    t.time "start_time"
    t.time "end_time"
    t.string "state"
    t.string "station"
    t.time "time"
    t.integer "business_user_id"
    t.integer "cancel_price"
    t.integer "price"
    t.integer "total_price"
    t.integer "service_fee"
    t.integer "trans_fee"
    t.integer "tax"
    t.string "postal_code"
    t.string "prefecture_code"
    t.string "city"
    t.string "street"
    t.boolean "done", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_reservations_on_post_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "business_user_id", null: false
    t.bigint "user_id", null: false
    t.text "comment"
    t.float "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_user_id"], name: "index_reviews_on_business_user_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "reservation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_rooms_on_reservation_id"
  end

  create_table "user_rooms", force: :cascade do |t|
    t.integer "user_id"
    t.integer "business_user_id"
    t.integer "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_i"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "meta"
    t.string "image"
    t.string "id_front_image"
    t.string "id_back_image"
    t.boolean "id_cert", default: false, null: false
    t.string "identification"
    t.string "name", default: "未設定", null: false
    t.text "self_introduction", default: "よろしくお願いします。"
    t.date "birth"
    t.integer "gender"
    t.string "station"
    t.integer "postal_code"
    t.string "prefecture_code"
    t.string "city"
    t.string "street"
    t.string "other_address"
    t.integer "tel"
    t.string "family_name"
    t.string "first_name"
    t.string "family_name_kana"
    t.string "first_name_kana"
    t.integer "station_id"
    t.integer "ward_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "business_user_category_relations", "business_users"
  add_foreign_key "business_user_category_relations", "categories"
  add_foreign_key "business_user_treatment_areas", "business_users"
  add_foreign_key "cards", "users"
  add_foreign_key "favorites", "business_users"
  add_foreign_key "favorites", "users"
  add_foreign_key "messages", "business_users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "off_businesses", "business_users"
  add_foreign_key "post_category_relations", "business_users"
  add_foreign_key "post_category_relations", "categories"
  add_foreign_key "post_category_relations", "posts"
  add_foreign_key "rankings", "business_users"
  add_foreign_key "reservations", "posts"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "business_users"
  add_foreign_key "reviews", "users"
  add_foreign_key "rooms", "reservations"
end
