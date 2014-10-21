var React = require('react');

var ListInfo = React.createClass({
  getDefaultProps: function() {
    return {
      shownSize: 0,
      allSize: 0
    };
  },
  render: function() {
      return (
        <div className='text-center lead'>
          {this.props.shownSize} von {this.props.allSize} Angeboten werden angezeigt
        </div>
      );
    }
});

module.exports = ListInfo;
