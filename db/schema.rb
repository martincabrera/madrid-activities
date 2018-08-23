# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_180_820_170_025) do
  create_table 'activities', force: :cascade do |t|
    t.string 'name'
    t.decimal 'hours_spent', precision: 4, scale: 2
    t.string 'category'
    t.string 'location'
    t.string 'district'
    t.decimal 'latitude', precision: 11, scale: 7
    t.decimal 'longitude', precision: 11, scale: 7
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category'], name: 'index_activities_on_category'
    t.index ['district'], name: 'index_activities_on_district'
    t.index ['location'], name: 'index_activities_on_location'
  end

  create_table 'opening_hours', force: :cascade do |t|
    t.integer 'activity_id'
    t.string 'day_of_the_week'
    t.integer 'start_hour'
    t.integer 'end_hour'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['activity_id'], name: 'index_opening_hours_on_activity_id'
    t.index ['end_hour'], name: 'index_opening_hours_on_end_hour'
    t.index ['start_hour'], name: 'index_opening_hours_on_start_hour'
  end
end
