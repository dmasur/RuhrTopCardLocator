/** @jsx React.DOM */

var ListInfo = require('./ListInfo');

var Offers = React.createClass({displayName: 'Offers',
  render: function() {
      return (
        React.DOM.div({className: "row"}, 
          React.DOM.div({className: "col-lg-10"}, 
            ListInfo({shownSize: "5", allSize: "10"})
          )
        )
      );
    }
});

module.exports = Offers;

var domready = require("domready");

domready(function () {
  React.renderComponent(Offers(), document.getElementById('offers-list'));
});
