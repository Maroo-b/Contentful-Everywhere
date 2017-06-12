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

ActiveRecord::Schema.define(version: 20170612171911) do

  create_table "brands", force: :cascade do |t|
    t.string "company_name"
    t.string "logo"
    t.text "description"
    t.string "website"
    t.string "twitter"
    t.string "email"
    t.string "contentful_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contentful_id"], name: "index_brands_on_contentful_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "icon"
    t.text "category_description"
    t.string "contentful_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contentful_id"], name: "index_categories_on_contentful_id"
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "product_id", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "url"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_images_on_product_id"
  end

  create_table "phones", force: :cascade do |t|
    t.string "number"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_phones_on_brand_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.string "slug"
    t.text "product_description"
    t.string "sizetypecolor"
    t.decimal "price"
    t.integer "quantity"
    t.string "sku"
    t.string "website"
    t.string "contentful_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "brand_id"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["contentful_id"], name: "index_products_on_contentful_id"
  end

  create_table "products_tags", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "tag_id", null: false
  end

  create_table "sync_traces", force: :cascade do |t|
    t.string "sync_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
