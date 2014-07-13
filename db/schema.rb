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

ActiveRecord::Schema.define(:version => 20140710213227) do

  create_table "gtfs_agency", :primary_key => "agency_id", :force => true do |t|
    t.text "agency_name",     :null => false
    t.text "agency_url",      :null => false
    t.text "agency_timezone", :null => false
    t.text "agency_lang"
    t.text "agency_phone"
    t.text "fare_url"
  end

  add_index "gtfs_agency", ["agency_id"], :name => "sqlite_autoindex_gtfs_agency_1", :unique => true

  create_table "gtfs_calendar", :primary_key => "service_id", :force => true do |t|
    t.integer "monday",     :null => false
    t.integer "tuesday",    :null => false
    t.integer "wednesday",  :null => false
    t.integer "thursday",   :null => false
    t.integer "friday",     :null => false
    t.integer "saturday",   :null => false
    t.integer "sunday",     :null => false
    t.date    "start_date", :null => false
    t.date    "end_date",   :null => false
  end

  add_index "gtfs_calendar", ["service_id"], :name => "sqlite_autoindex_gtfs_calendar_1", :unique => true

  create_table "gtfs_calendar_dates", :id => false, :force => true do |t|
    t.text    "service_id"
    t.date    "date",           :null => false
    t.integer "exception_type", :null => false
  end

  create_table "gtfs_directions", :primary_key => "direction_id", :force => true do |t|
    t.text "description"
  end

  add_index "gtfs_directions", ["direction_id"], :name => "sqlite_autoindex_gtfs_directions_1", :unique => true

  create_table "gtfs_fare_attributes", :primary_key => "fare_id", :force => true do |t|
    t.float   "price",             :null => false
    t.text    "currency_type",     :null => false
    t.integer "payment_method"
    t.integer "transfers"
    t.integer "transfer_duration"
    t.text    "agency_id"
  end

  add_index "gtfs_fare_attributes", ["fare_id"], :name => "sqlite_autoindex_gtfs_fare_attributes_1", :unique => true

  create_table "gtfs_fare_rules", :id => false, :force => true do |t|
    t.text    "fare_id"
    t.text    "route_id"
    t.integer "origin_id"
    t.integer "destination_id"
    t.integer "contains_id"
    t.text    "service_id"
  end

  create_table "gtfs_feed_info", :id => false, :force => true do |t|
    t.text "feed_publisher_name"
    t.text "feed_publisher_url"
    t.text "feed_timezone"
    t.text "feed_lang"
    t.text "feed_version"
  end

  create_table "gtfs_frequencies", :id => false, :force => true do |t|
    t.text    "trip_id"
    t.text    "start_time",         :null => false
    t.text    "end_time",           :null => false
    t.integer "headway_secs",       :null => false
    t.integer "start_time_seconds"
    t.integer "end_time_seconds"
  end

  create_table "gtfs_location_types", :primary_key => "location_type", :force => true do |t|
    t.text "description"
  end

  add_index "gtfs_location_types", ["location_type"], :name => "sqlite_autoindex_gtfs_location_types_1", :unique => true

  create_table "gtfs_payment_methods", :primary_key => "payment_method", :force => true do |t|
    t.text "description"
  end

  add_index "gtfs_payment_methods", ["payment_method"], :name => "sqlite_autoindex_gtfs_payment_methods_1", :unique => true

  create_table "gtfs_pickup_dropoff_types", :primary_key => "type_id", :force => true do |t|
    t.text "description"
  end

  add_index "gtfs_pickup_dropoff_types", ["type_id"], :name => "sqlite_autoindex_gtfs_pickup_dropoff_types_1", :unique => true

  create_table "gtfs_route_types", :primary_key => "route_type", :force => true do |t|
    t.text "description"
  end

  add_index "gtfs_route_types", ["route_type"], :name => "sqlite_autoindex_gtfs_route_types_1", :unique => true

  create_table "gtfs_routes", :primary_key => "route_id", :force => true do |t|
    t.text    "agency_id"
    t.text    "route_short_name", :default => ""
    t.text    "route_long_name",  :default => ""
    t.text    "route_desc"
    t.integer "route_type"
    t.text    "route_url"
    t.text    "route_color"
    t.text    "route_text_color"
  end

  add_index "gtfs_routes", ["route_id"], :name => "sqlite_autoindex_gtfs_routes_1", :unique => true

  create_table "gtfs_shapes", :id => false, :force => true do |t|
    t.text    "shape_id",            :null => false
    t.float   "shape_pt_lat",        :null => false
    t.float   "shape_pt_lon",        :null => false
    t.integer "shape_pt_sequence",   :null => false
    t.float   "shape_dist_traveled"
  end

  create_table "gtfs_stop_times", :id => false, :force => true do |t|
    t.text    "trip_id"
    t.text    "arrival_time"
    t.text    "departure_time"
    t.text    "stop_id"
    t.integer "stop_sequence",          :null => false
    t.text    "stop_headsign"
    t.integer "pickup_type"
    t.integer "drop_off_type"
    t.float   "shape_dist_traveled"
    t.integer "timepoint"
    t.integer "arrival_time_seconds"
    t.integer "departure_time_seconds"
  end

  add_index "gtfs_stop_times", ["arrival_time_seconds"], :name => "arr_time_index"
  add_index "gtfs_stop_times", ["departure_time_seconds"], :name => "dep_time_index"
  add_index "gtfs_stop_times", ["trip_id", "stop_sequence"], :name => "stop_seq_index"

  create_table "gtfs_stops", :primary_key => "stop_id", :force => true do |t|
    t.text    "stop_name",      :null => false
    t.text    "stop_desc"
    t.float   "stop_lat"
    t.float   "stop_lon"
    t.integer "zone_id"
    t.text    "stop_url"
    t.text    "stop_code"
    t.text    "stop_street"
    t.text    "stop_city"
    t.text    "stop_region"
    t.text    "stop_postcode"
    t.text    "stop_country"
    t.integer "location_type"
    t.text    "parent_station"
    t.text    "stop_timezone"
    t.string  "slug"
  end

  add_index "gtfs_stops", ["stop_id"], :name => "sqlite_autoindex_gtfs_stops_1", :unique => true

  create_table "gtfs_transfer_types", :primary_key => "transfer_type", :force => true do |t|
    t.text "description"
  end

  add_index "gtfs_transfer_types", ["transfer_type"], :name => "sqlite_autoindex_gtfs_transfer_types_1", :unique => true

  create_table "gtfs_transfers", :id => false, :force => true do |t|
    t.text    "from_stop_id"
    t.text    "to_stop_id"
    t.integer "transfer_type"
    t.integer "min_transfer_time"
    t.text    "from_route_id"
    t.text    "to_route_id"
    t.text    "service_id"
  end

  create_table "gtfs_trips", :primary_key => "trip_id", :force => true do |t|
    t.text    "route_id"
    t.text    "service_id"
    t.text    "trip_headsign"
    t.integer "direction_id",    :null => false
    t.text    "block_id"
    t.text    "shape_id"
    t.text    "trip_short_name"
  end

  add_index "gtfs_trips", ["trip_id"], :name => "sqlite_autoindex_gtfs_trips_1", :unique => true

  create_table "service_combinations", :id => false, :force => true do |t|
    t.integer "combination_id"
    t.text    "service_id"
  end

# Could not dump table "service_combo_ids" because of following StandardError
#   Unknown type 'serial' for column 'combination_id'

end
