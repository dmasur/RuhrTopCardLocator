React = require 'react'
Stars = require './Stars'

module.exports = React.createClass
  displayName: 'OfferRow'
  
  render: ->
    <tr className='offer-row'>
      <td className='name'>{@props.offer.name}</td>
      <td>{@props.offer.category}</td>
      <td><Stars count={@props.offer.rating} /></td>
      <td>{@props.offer.distanceString}</td>
    </tr>
