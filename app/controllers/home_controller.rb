class HomeController < ApplicationController

  def index
    @stations = Gtfs_stops.order('cast(stop_id as int)')
  end

  # Show the stop times, both inbound and outbound, for a provided stop 
  def stop_times(forApi = false)
    @toPhiladelphia = []
    @toLindenwold = []

    @dateToUse = Time.zone.now
    @times = getStopTimes(@dateToUse)

    @times.each do |s|
      # Note: route_id of 1 is to LINDENWOLD and
      # route_id of 2 is to PHILADELPHIA
      if (s.route_id == "2")
        @toPhiladelphia.push(s)
      elsif (s.route_id == "1")
        @toLindenwold.push(s)
      end
    end

    # If either direction has fewer than three times, go to the next day
    if @toPhiladelphia.count < 3 or @toLindenwold.count < 3
      @times = getStopTimes((@dateToUse + 1.day).beginning_of_day)

      @times.each do |s| 
        # Note: route_id of 1 is to LINDENWOLD and
        # route_id of 2 is to PHILADELPHIA
        if (s.route_id == "2")
          @toPhiladelphia.push(s)
        elsif (s.route_id == "1")
          @toLindenwold.push(s)
        end
      end
    end

    if forApi == true
      return { :to_phila => @toPhiladelphia.first, :to_lindenwold => @toLindenwold.first }
    end
  end

  # Get the details of a specific trip, based around a specific stop
  def trip_details
    @thisStation =
      Gtfs_stops.find_by_slug(params[:station])

    @tripStopTimes =
      Gtfs_stop_times
        .select('stop_times.*, stops.stop_name')
        .joins("inner join stops on stop_times.stop_id = stops.stop_id")
        .where('stop_times.trip_id = ?', params[:trip])
        .order('departure_time asc')

    @timeAtThisStop =
      @tripStopTimes.where('stop_times.stop_id = ?', @thisStation.stop_id).first.departure_time
  end

  # Used for the Alexa API endpoint
  def api
    nextTrains = stop_times(true)

    if params[:direction] == "westbound"
      trainJson = nextTrains[:to_phila]
    else
      trainJson = nextTrains[:to_lindenwold]
    end

    render :json => trainJson
  end

  private

  def getStopTimes(dateTime)
    if params[:station].is_number?
      s = Gtfs_stops.find_by_stop_id(params[:station])
    else
      s = Gtfs_stops.find_by_slug(params[:station])
    end

    # Get the name of the station with the provided id
    @theStation = s

    # Figure out which service id to use based on what day it is, and if it's a holiday or not
    holidayDay = Gtfs_calendar_dates
      .where('date = ? and exception_type = 1', dateTime.strftime('%Y%m%d'))

    if (holidayDay.count > 0)
      todaysServiceId = holidayDay.first.service_id
    else 
      case dateTime.strftime('%A').downcase
        when "monday"
          todaysServiceId = Gtfs_calendar.where("monday = ? and ? between start_date and end_date", 1, dateTime.strftime('%Y%m%d')).first.service_id
        when "tuesday"
          todaysServiceId = Gtfs_calendar.where("tuesday = ? and ? between start_date and end_date", 1, dateTime.strftime('%Y%m%d')).first.service_id
        when "wednesday"
          todaysServiceId = Gtfs_calendar.where("wednesday = ? and ? between start_date and end_date", 1, dateTime.strftime('%Y%m%d')).first.service_id
        when "thursday"
          todaysServiceId = Gtfs_calendar.where("thursday = ? and ? between start_date and end_date", 1, dateTime.strftime('%Y%m%d')).first.service_id
        when "friday"
          todaysServiceId = Gtfs_calendar.where("friday = ? and ? between start_date and end_date", 1, dateTime.strftime('%Y%m%d')).first.service_id
        when "saturday"
          todaysServiceId = Gtfs_calendar.where("saturday = ? and ? between start_date and end_date", 1, dateTime.strftime('%Y%m%d')).first.service_id
        when "sunday"
          todaysServiceId = Gtfs_calendar.where("sunday = ? and ? between start_date and end_date", 1, dateTime.strftime('%Y%m%d')).first.service_id
      end
    end

    @debug_serviceId = todaysServiceId
    @debug_stopId = s.id

    Gtfs_stop_times
      .select('stop_times.*, trips.direction_id, trips.route_id')
      .where('stop_id = ? and departure_time > ?', s.id, dateTime.strftime('%H:%M:%S')).order('departure_time')
      .joins('LEFT OUTER JOIN trips ON stop_times.trip_id = trips.trip_id').where('trips.service_id = ?', todaysServiceId)
  end
end

class String
  def is_number?
    true if Float(self) rescue false
  end
end
