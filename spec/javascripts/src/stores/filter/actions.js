var ReactFlux, filterConstants;

ReactFlux = require('react-flux');

filterConstants = require('./constants');

module.exports = ReactFlux.createActions({
  update: [filterConstants.UPDATE]
});
