/** @jsx React.DOM */

var ListInfo = require('./ListInfo');
var Sidebar = require('./Sidebar');
var OffersList = require('./OffersList');

var Offers = React.createClass({displayName: 'Offers',
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return (
      React.DOM.div(null, 
        React.DOM.div({className: "col-lg-2"}, 
          Sidebar(null)
        ), 
        React.DOM.div({className: "col-lg-10"}, 
          ListInfo({shownSize: this.props.offers.length, allSize: this.props.offers.length}), 
          OffersList({offers: this.props.offers})
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
