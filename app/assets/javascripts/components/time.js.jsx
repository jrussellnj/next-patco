var Times = React.createClass({
  getInitialState: function() {
    return { direction: '', times: [] }
  },

  render: function() {
    console.log(this.props);
    var furtherTimes = this.props.times.map(function(time) {
      return (
        <FurtherTime time={time} />
      );
    });

    var nextTime = this.props.times.length > 0 ? this.props.times[0].departure_time : '';

    return (
      <div className="time-listing">
        <h3>NEXT TO<br />{this.props.direction}</h3>
        <div className="time next">{nextTime}</div>
        <div> <ul className="upcoming-trains">{furtherTimes}</ul></div>
      </div>
    );
  }
});

var FurtherTime = React.createClass({
  getInitialState: function() {
    return { time: '' }
  },
  
  render: function() {
    var departure = this.props.time != '' ? this.props.time.departure_time : '';

    return (
      <li className="time">
        {departure}
      </li>
    );
  }
});
