React = require 'react'

OfferRow = React.createClass
  render: ->
    <tr className='offer-row'>
      <td className='name'>{this.props.offer.name}</td>
      <td>{this.props.offer.category}</td>
      <td></td>
      <td></td>
    </tr>

module.exports = OfferRow;
