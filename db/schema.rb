# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

  create_table "boxes", :force => true do |t|
    t.string   "title"
    t.integer  "number"
    t.string   "size"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", :force => true do |t|
    t.string   "title"
    t.string   "record_group"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_files", :force => true do |t|
    t.string   "name"
    t.string   "path_from_root"
    t.string   "citation_link"
    t.integer  "pagenum"
    t.integer  "letter_id"
    t.text     "transcription"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_original_url"
    t.integer  "folder_id"
  end

  create_table "folders", :force => true do |t|
    t.string   "title"
    t.integer  "number"
    t.integer  "number_within_box"
    t.integer  "box_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "letters", :force => true do |t|
    t.date     "letter_date"
    t.string   "author_name"
    t.integer  "author_place_id"
    t.integer  "birth_place_id"
    t.date     "birth_date"
    t.integer  "author_relation_to_bcperson"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "letters_topics", :id => false, :force => true do |t|
    t.integer "letter_id"
    t.integer "topic_id"
  end

  create_table "places", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "postalcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.string   "title"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
