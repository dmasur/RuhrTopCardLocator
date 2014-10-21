/** @jsx React.DOM */

var OffersInfo = React.createClass({displayName: 'OffersInfo',
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return (
      React.DOM.div(null, 
        OfferInfo({offer: offer})
      )
    );
  }
});

module.exports = OffersInfo;
