var React = require('react');
var OfferRow = require('./OfferRow.jsx');

var OffersList = React.createClass({
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    var rows = [];
    this.props.offers.forEach(function(offer) {
      rows.push(<OfferRow offer={offer} />);
    });
    return (
      <table className='table table-striped'>
        <thead>
          <tr>
            <td>Name</td>
            <td>Kategorie</td>
            <td>Bewertung</td>
            <td>Entfernung</td>
            <td></td>
          </tr>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </table>
    );
  }
});

module.exports = OffersList;
