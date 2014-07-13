class AddSlugToGtfsStops < ActiveRecord::Migration
  def change
    add_column :gtfs_stops, :slug, :string
  end
end
