//= require_tree ./components

/* The app that drives the site */
var App = React.createClass({
  getInitialState: function() {
    return { stations: [] }
  },

  componentDidMount: function() {
    /* Get the list of stations */
    $.ajax({
      url: this.props.url,
      type: 'GET',
      cache: false,
      success: function(data) {
        this.setState({ stations: data });
      }.bind(this)
    });
  },
  
  render: function() {
    return (
      <StationList stations={this.state.stations} />
    );
  }
});

$(document).ready(function() {
  ReactDOM.render(<App url="/api/stations" />, document.getElementById('main'));
});
