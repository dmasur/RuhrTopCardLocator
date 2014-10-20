/** @jsx React.DOM */

var ListInfo = require('./ListInfo');

var Offers = React.createClass({displayName: 'Offers',
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return (
      React.DOM.div({className: "row"}, 
        React.DOM.div({className: "col-lg-10"}, 
          ListInfo({shownSize: this.props.offers.length, allSize: this.props.offers.length})
        )
      )
    );
  }
});

module.exports = Offers;

if (typeof($) != "undefined") {
  var domready = require("domready");

  domready(function () {
    element = document.getElementById('offers-list')
    data = $(element).data()
    React.renderComponent(Offers(data), element);
  });
}
