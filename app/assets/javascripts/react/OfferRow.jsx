/** @jsx React.DOM */

var OfferRow = React.createClass({
  render: function() {
    return (
      <tr>
        <td>{this.props.offer.name}</td>
        <td>{this.props.offer.category}</td>
        <td></td>
        <td></td>
      </tr>
    );
  }
});

module.exports = OfferRow;
