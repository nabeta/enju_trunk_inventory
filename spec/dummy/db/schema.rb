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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130719103823) do

  create_table "enju_trunk_inventory_inventory_check_data_import_results", :force => true do |t|
    t.integer  "inventory_check_data_import_file_id"
    t.text     "body"
    t.text     "error_msg"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "inventory_check_data", :force => true do |t|
    t.integer  "inventory_manage_id",                :null => false
    t.string   "readcode",                           :null => false
    t.datetime "read_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "shelf_flag",          :default => 0
    t.string   "shelf_name"
  end

  create_table "inventory_check_data_import_files", :force => true do |t|
    t.string   "content_type"
    t.integer  "size"
    t.string   "file_hash"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "imported_at"
    t.string   "state"
    t.string   "inventory_check_data_import_file_name"
    t.string   "inventory_check_data_import_content_type"
    t.integer  "inventory_check_data_import_file_size"
    t.datetime "inventory_check_data_import_updated_at"
    t.string   "edit_mode"
    t.integer  "inventory_manage_id",                      :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "inventory_check_data_import_results", :force => true do |t|
    t.integer  "inventory_check_data_import_file_id"
    t.integer  "user_id"
    t.text     "body"
    t.text     "error_msg"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "inventory_check_results", :force => true do |t|
    t.integer  "inventory_manage_id"
    t.integer  "status_1"
    t.integer  "status_2"
    t.integer  "status_3"
    t.integer  "status_4"
    t.integer  "status_5"
    t.integer  "status_6"
    t.integer  "status_7"
    t.integer  "status_8"
    t.integer  "status_9"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "item_identifier"
    t.integer  "skip_flag",           :default => 0
  end

  add_index "inventory_check_results", ["item_identifier"], :name => "index_inventory_check_results_on_item_identifier"
  add_index "inventory_check_results", ["skip_flag"], :name => "index_inventory_check_results_on_skip_flag"
  add_index "inventory_check_results", ["status_1", "status_2", "status_3", "status_4", "status_5", "status_6", "status_7", "status_8", "status_9"], :name => "inventory_check_results_index_1"

  create_table "inventory_manages", :force => true do |t|
    t.string   "display_name"
    t.string   "manifestation_type_ids"
    t.string   "shelf_group_ids"
    t.text     "notification_dest"
    t.integer  "state",                  :default => 0,   :null => false
    t.datetime "finished_at"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "bind_type",              :default => "0", :null => false
    t.datetime "check_started_at"
    t.datetime "check_finished_at"
  end

  create_table "inventory_shelf_barcode_import_files", :force => true do |t|
    t.string   "content_type"
    t.integer  "size"
    t.string   "file_hash"
    t.integer  "user_id"
    t.text     "note"
    t.datetime "imported_at"
    t.string   "state"
    t.string   "inventory_shelf_barcode_import_file_name"
    t.string   "inventory_shelf_barcode_import_content_type"
    t.integer  "inventory_shelf_barcode_import_file_size"
    t.datetime "inventory_shelf_barcode_import_updated_at"
    t.string   "edit_mode"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "inventory_manage_id"
  end

  create_table "inventory_shelf_barcode_import_results", :force => true do |t|
    t.integer  "inventory_shelf_barcode_import_file_id"
    t.integer  "user_id"
    t.text     "body"
    t.text     "error_msg"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "inventory_shelf_barcodes", :force => true do |t|
    t.string   "barcode"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "inventory_manage_id"
    t.integer  "inventory_shelf_group_id"
    t.integer  "shelf_id"
  end

  create_table "inventory_shelf_groups", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
