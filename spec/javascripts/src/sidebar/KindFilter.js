var Button, ButtonGroup, React, ReactFlux, filterActions, filterStore;

React = require('react');

Button = require('react-bootstrap/Button');

ButtonGroup = require('react-bootstrap/ButtonGroup');

filterStore = require('../stores/filter/store');

filterActions = require('../stores/filter/actions');

ReactFlux = require('react-flux');

module.exports = React.createClass({
  mixins: [ReactFlux.mixin(filterStore)],
  getStateFromStores: function() {
    return {
      free: filterStore.state.get('free'),
      halfPrice: filterStore.state.get('halfPrice'),
      special: filterStore.state.get('special')
    };
  },
  updateFilter: function(event) {
    var filters;
    filters = this.state;
    filters[event.target.name] = !filters[event.target.name];
    filterActions.update(filters);
    return event.target.blur();
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
      "active": this.state.free,
      "onClick": this.updateFilter
    }, "Kostenlos"), React.createElement(Button, {
      "name": 'halfPrice',
      "active": this.state.halfPrice,
      "onClick": this.updateFilter
    }, "Halber Preis"), React.createElement(Button, {
      "name": 'special',
      "active": this.state.special,
      "onClick": this.updateFilter
    }, "Spezial")));
  }
});
