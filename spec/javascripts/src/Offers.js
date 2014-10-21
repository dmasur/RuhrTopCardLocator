var ListInfo, Offers, OffersList, React, Sidebar;

React = require('react');

ListInfo = require('./ListInfo');

Sidebar = require('./Sidebar');

OffersList = require('./OffersList');

Offers = React.createClass({
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return React.createElement(React.DOM.div, null, React.createElement(React.DOM.div, {
      "className": 'col-lg-2'
    }, React.createElement(Sidebar, null)), React.createElement(React.DOM.div, {
      "className": 'col-lg-10'
    }, React.createElement(ListInfo, {
      "shownSize": this.props.offers.length,
      "allSize": this.props.offers.length
    }), React.createElement(OffersList, {
      "offers": this.props.offers
    })));
  }
});

module.exports = Offers;
