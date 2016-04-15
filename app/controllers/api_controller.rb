class ApiController < ApplicationController
  def stations
    render :json => Gtfs_stops.order('cast(stop_id as int)').to_json
  end

  def times
  end
end
