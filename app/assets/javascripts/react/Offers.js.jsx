/** @jsx React.DOM */

var ListInfo = require('./ListInfo');

var Offers = React.createClass({
  render: function() {
      return (
        <div className='row'>
          <div className='col-lg-10'>
            <ListInfo shownSize='5' allSize='10' />
          </div>
        </div>
      );
    }
});

module.exports = Offers;

var domready = require("domready");

domready(function () {
  React.renderComponent(Offers(), document.getElementById('offers-list'));
});
