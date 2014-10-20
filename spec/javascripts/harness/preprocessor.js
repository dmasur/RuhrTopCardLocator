var coffee = require('coffee-script');
var ReactTools = require('react-tools');

module.exports = {
  process: function(src, path) {
    if (path.match(/\.coffee$/)) {
      return coffee.compile(src, {'bare': true});
    }
    return ReactTools.transform(src);
  }
};