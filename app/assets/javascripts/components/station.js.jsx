var StationList = React.createClass({
  render: function() {
    var stations = this.props.stations.map(function(station) {
      return (
        <StationListing station={station} />
      );
    });

    return (
      <div className="stops">{stations}</div>
    );
  }
});

var StationListing = React.createClass({
  showStation: function(station, e) {
    e.preventDefault();
    history.pushState(null, null, station.slug);
    stationTimesUrl = "/api/times/" + station.slug;
    ReactDOM.render(<StationDetails station={station} url={stationTimesUrl} />, document.getElementById('main'));
  },

  render: function() {
    console.log(this.props.station);
    return (
      <a href='#' onClick={this.showStation.bind(this, this.props.station)}><img src="/assets/pin.png" /> {this.props.station.stop_name}</a>
    );
  }
});

var StationDetails = React.createClass({
  getInitialState: function() {
    return { times: { 'toPhiladelphia': [], 'toLindenwold': [] } }
  },

  componentDidMount: function() {
    /* Get times to Philadelphia and Lindenwold */
    $.ajax({
      url: this.props.url,
      type: 'GET',
      cache: false,
      success: function(data) {
        this.setState({ times: data });
        console.log("TIMES!", data);
      }.bind(this)
    });
  },

  render: function() {
    console.log("RENDERING!");
    return (
      <div>
        <h2 className="station-name"><img src="/assets/pin.png" /> {this.props.station.stop_name}</h2>
        <Times direction="PHILADELPHIA" times={this.state.times.toPhiladelphia} />
        <hr />
        <Times direction="LINDENWOLD" times={this.state.times.toLindenwold} />
      </div>
    );
  }
});

/*

        <div className="time-listing" id="upcoming-philadelphia">
          <h3>NEXT TO<br />PHILADELPHIA</h3>
          <div id="next-philadelphia"></div>
          <div className="upcoming"></div>
        </div>

        <hr />

        <div className="time-listing" id="upcoming-lindenwold">
          <h3>NEXT TO<br />LINDENWOLD</h3>
          <div id="next-lindenwold"></div>
          <div className="upcoming"></div>
        </div>
      </div>
*/


/*
var LocationList = React.createClass({
  render: function() {
    var locationNodes = this.props.data.map(function(location) {
      return (
        <Location trip={location.trip} />
      );
    });

    return (
      <div className="location-list">
        Location List.
        {locationNodes}
      </div>
    );
  }
});

var Location = React.createClass({
  render: function() {
    return (
      <div className="location">
        {this.props.trip}
      </div>
    );
  }
});
*/
