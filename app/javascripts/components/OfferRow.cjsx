React = require 'react'

module.exports = React.createClass
  render: ->
    <tr className='offer-row'>
      <td className='name'>{@props.offer.name}</td>
      <td>{@props.offer.category}</td>
      <td></td>
      <td></td>
    </tr>
