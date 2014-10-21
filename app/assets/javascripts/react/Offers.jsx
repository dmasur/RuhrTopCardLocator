/** @jsx React.DOM */

var ListInfo = require('./ListInfo');
var Sidebar = require('./Sidebar');
var OffersList = require('./OffersList');

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

if (typeof($) != "undefined") {
  var domready = require("domready");

  domready(function () {
    element = document.getElementById('offers-list')
    data = $(element).data()
    React.renderComponent(Offers(data), element);
  });
}
