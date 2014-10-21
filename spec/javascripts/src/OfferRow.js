var OfferRow, React;

React = require('react');

OfferRow = React.createClass({
  render: function() {
    return React.createElement(React.DOM.tr, null, React.createElement(React.DOM.td, null, this.props.offer.name), React.createElement(React.DOM.td, null, this.props.offer.category), React.createElement(React.DOM.td, null), React.createElement(React.DOM.td, null));
  }
});

module.exports = OfferRow;
