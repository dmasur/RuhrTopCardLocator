var OfferRow, OffersList, React;

React = require('react');

OfferRow = require('./OfferRow');

OffersList = React.createClass({
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    var rows;
    rows = [];
    this.props.offers.forEach(function(offer) {
      return rows.push(React.createElement(OfferRow, {
        "offer": offer
      }));
    });
    return React.createElement(React.DOM.table, {
      "className": 'table table-striped'
    }, React.createElement(React.DOM.thead, null, React.createElement(React.DOM.tr, null, React.createElement(React.DOM.td, null, "Name"), React.createElement(React.DOM.td, null, "Kategorie"), React.createElement(React.DOM.td, null, "Bewertung"), React.createElement(React.DOM.td, null, "Entfernung"), React.createElement(React.DOM.td, null))), React.createElement(React.DOM.tbody, null, rows));
  }
});

module.exports = OffersList;
