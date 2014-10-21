/** @jsx React.DOM */

var OfferRow = React.createClass({displayName: 'OfferRow',
  render: function() {
    return (
      React.DOM.tr(null, 
        React.DOM.td(null, this.props.offer.name), 
        React.DOM.td(null, this.props.offer.category), 
        React.DOM.td(null), 
        React.DOM.td(null)
      )
    );
  }
});

module.exports = OfferRow;
