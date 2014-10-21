var React = require('react');
var ListInfo = require('./ListInfo.jsx');
var Sidebar = require('./Sidebar.jsx');
var OffersList = require('./OffersList.jsx');

var Offers = React.createClass({
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return (
      <div>
        <div className='col-lg-2'>
          <Sidebar />
        </div>
        <div className='col-lg-10'>
          <ListInfo shownSize={this.props.offers.length} allSize={this.props.offers.length} />
          <OffersList offers={this.props.offers} />
        </div>
      </div>
    );
  }
});

module.exports = Offers;
