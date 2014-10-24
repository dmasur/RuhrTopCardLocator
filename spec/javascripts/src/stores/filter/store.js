var ReactFlux, filterConstants, jQuery;

ReactFlux = require('react-flux');

filterConstants = require('./constants');

jQuery = require('jquery');

module.exports = ReactFlux.createStore({
  getInitialState: function() {
    return {
      free: false,
      halfPrice: false,
      special: false
    };
  }
}, [
  [
    filterConstants.UPDATE, function(args) {
      var filters;
      filters = args[0];
      console.log("Set State to " + filters.free);
      return this.setState(filters);
    }
  ]
]);
