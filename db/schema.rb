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

ActiveRecord::Schema.define(version: 20140205113502) do

  create_table "cars", force: true do |t|
    t.integer "year"
    t.string  "make"
    t.string  "model"
    t.string  "trim"
    t.integer "purchase_mileage"
    t.decimal "purchase_price"
    t.date    "purchase_date"
    t.integer "current_value"
    t.integer "current_mileage"
  end

  create_table "parts", force: true do |t|
    t.integer "car_id"
    t.integer "project_id"
    t.string  "name"
    t.date    "replacement_date"
    t.text    "description"
    t.string  "manufacturer"
    t.string  "model_number"
    t.string  "vendor"
    t.decimal "purchase_price"
    t.boolean "warranty"
  end

  create_table "projects", force: true do |t|
    t.integer "car_id"
    t.string  "title"
    t.text    "description"
    t.integer "mileage"
    t.date    "start_date"
  end

end
