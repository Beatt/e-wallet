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

ActiveRecord::Schema.define(version: 2019_07_17_033806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "backs", force: :cascade do |t|
    t.bigint "value_in_cents", default: 0
    t.datetime "approved_at"
    t.datetime "invalid_at"
    t.string "error_message"
    t.string "error_code"
    t.string "type", null: false
    t.integer "account_recipient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.bigint "credit_card_id"
    t.bigint "tax_id"
    t.index ["credit_card_id"], name: "index_backs_on_credit_card_id"
    t.index ["customer_id"], name: "index_backs_on_customer_id"
    t.index ["tax_id"], name: "index_backs_on_tax_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "number", null: false
    t.string "expiration_date"
    t.string "brand", null: false
    t.string "kind", null: false
    t.string "country", default: "MX"
    t.string "last4", limit: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.string "cvc", null: false
    t.index ["customer_id"], name: "index_credit_cards_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "account_number"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secure_key", null: false
  end

  create_table "general_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "back_id"
    t.index ["back_id"], name: "index_general_accounts_on_back_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name", null: false
    t.integer "limit_value", null: false
    t.integer "minimum_value", null: false
    t.integer "percentage", null: false
    t.integer "fixed_rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "backs", "credit_cards"
  add_foreign_key "backs", "customers"
  add_foreign_key "backs", "customers", column: "account_recipient"
  add_foreign_key "backs", "taxes"
  add_foreign_key "credit_cards", "customers"
  add_foreign_key "general_accounts", "backs"
end
