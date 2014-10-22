var Button, ButtonGroup, React;

React = require('react');

Button = require('react-bootstrap/Button');

ButtonGroup = require('react-bootstrap/ButtonGroup');

module.exports = React.createClass({
  updateFilter: function(event) {
    var filters;
    filters = this.props.filters;
    filters[event.target.name] = !filters[event.target.name];
    event.target.blur();
    return this.props.updateFilter(filters);
  },
  render: function() {
    return React.createElement(React.DOM.div, {
      "className": 'kinds'
    }, React.createElement(React.DOM.h5, {
      "className": 'text-center'
    }, "Arten"), React.createElement(ButtonGroup, {
      "vertical": true
    }, React.createElement(Button, {
      "name": 'free',
      "active": this.props.filters.free,
      "onClick": this.updateFilter
    }, "Kostenlos"), React.createElement(Button, {
      "name": 'halfPrice',
      "active": this.props.filters.halfPrice,
      "onClick": this.updateFilter
    }, "Halber Preis"), React.createElement(Button, {
      "name": 'special',
      "active": this.props.filters.special,
      "onClick": this.updateFilter
    }, "Spezial")));
  }
});
