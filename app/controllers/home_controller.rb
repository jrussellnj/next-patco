class HomeController < ApplicationController
  def index
    # Get the list of station stops
    @stations = Gtfs_stops.all
  end

  # Show the stop times, both inbound and outbound, for a provided stop 
  def stop_times
    # Get the name of the station with the provided id
    @theStation = Gtfs_stops.find_by_stop_id(params[:station_id]).stop_name

    # Figure out which service id to use based on what day it is
    case DateTime.now.strftime('%A').downcase
      when "monday", "tuesday", "wednesday", "thursday"
        todaysServiceId = Gtfs_calendar.where("monday = ?", 1).first.service_id
      when "friday"
        todaysServiceId = Gtfs_calendar.where("friday = ?", 1).first.service_id
      when "saturday"
        todaysServiceId = Gtfs_calendar.where("saturday = ?", 1).first.service_id
      when "sunday"
        todaysServiceId = Gtfs_calendar.where("sunday = ?", 1).first.service_id
    end

    # Get the times for a particular stop
    currentTime = Time.now.strftime("%H:%M:%S")

    # Override, if needed for testing
    # currentTime = "08:30:00"

    @times = 
      Gtfs_stop_times
        .select('gtfs_stop_times.*, gtfs_trips.direction_id')
        .where('stop_id = ? and departure_time > ?', params[:station_id], currentTime).order('departure_time')
        .joins('LEFT OUTER JOIN gtfs_trips ON gtfs_stop_times.trip_id = gtfs_trips.trip_id').where('gtfs_trips.service_id = ?', todaysServiceId)

    @toPhiladelphia = []
    @toLindenwold = []

    @times.each do |s| 
      # Note: direction_id of 1 is to LINDENWOLD and
      # direction_id of 0 is to PHILADELPHIA
      if (s.direction_id == 0)
        @toPhiladelphia.push(s)
      else
        @toLindenwold.push(s)
      end

      #@toPhiladelphia.slice!(0, @toPhiladelphia.length < 9 ?  @toPhiladelphia.length : 9)
      #@toLindenwold.slice!(0, @toLindenwold.length < 9 ?  @toLindenwold.length : 9)

    end
  end

  # Get the details of a specific trip, based around a specific stop
  def trip_details
    @tripStopTimes =
      Gtfs_stop_times
        .select('gtfs_stop_times.*, gtfs_stops.stop_name')
        .joins("inner join gtfs_stops on gtfs_stop_times.stop_id = gtfs_stops.stop_id")
        .where('gtfs_stop_times.trip_id = ?', params[:trip_id])
        .order('departure_time asc')
  end
end
