/** @jsx React.DOM */

var ListInfo = require('./ListInfo');

var Offers = React.createClass({
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return (
      <div className='row'>
        <div className='col-lg-10'>
          <ListInfo shownSize={this.props.offers.length} allSize={this.props.offers.length} />
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
