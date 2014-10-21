/** @jsx React.DOM */

var OfferRow = require('./OfferRow');

var OffersList = React.createClass({displayName: 'OffersList',
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    var rows = [];
    this.props.offers.forEach(function(offer) {
      rows.push(OfferRow({offer: offer}));
    });
    return (
      React.DOM.table({className: "table table-striped"}, 
        React.DOM.thead(null, 
          React.DOM.tr(null, 
            React.DOM.td(null, "Name"), 
            React.DOM.td(null, "Kategorie"), 
            React.DOM.td(null, "Bewertung"), 
            React.DOM.td(null, "Entfernung"), 
            React.DOM.td(null)
          )
        ), 
        React.DOM.tbody(null, 
          rows
        )
      )
    );
  }
});

module.exports = OffersList;
