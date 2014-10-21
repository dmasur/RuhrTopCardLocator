var ListInfo, React;

React = require('react');

ListInfo = React.createClass({
  getDefaultProps: function() {
    return {
      shownSize: 0,
      allSize: 0
    };
  },
  render: function() {
    return React.createElement(React.DOM.div, {
      "className": 'text-center lead'
    }, this.props.shownSize, " von ", this.props.allSize, " Angeboten werden angezeigt");
  }
});

module.exports = ListInfo;
