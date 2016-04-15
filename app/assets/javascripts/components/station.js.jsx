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
    ReactDOM.render(<StationDetails station={station} />, document.getElementById('main'));
  },

  render: function() {
    console.log(this.props.station);
    return (
      <a href='#' onClick={this.showStation.bind(this, this.props.station)}><img src="/assets/pin.png" /> {this.props.station.stop_name}</a>
    );
  }
});

var StationDetails = React.createClass({

  render: function() {
    return (
      <div>
        <h2 className="station-name"><img src="/assets/pin.png" /> {this.props.station.stop_name}</h2>
      </div>
    );
  }
});


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
