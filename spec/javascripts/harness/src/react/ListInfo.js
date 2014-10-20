/** @jsx React.DOM */

var ListInfo = React.createClass({displayName: 'ListInfo',
  getDefaultProps: function() {
    return {
      shownSize: 0,
      allSize: 0
    };
  },
  render: function() {
      return (
        React.DOM.div({className: "text-center lead"}, 
          this.props.shownSize, " von ", this.props.allSize, " Angeboten werden angezeigt"
        )
      );
    }
});

module.exports = ListInfo;
