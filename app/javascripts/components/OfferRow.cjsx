React = require 'react'
Stars = require './Stars'
Button = require 'react-bootstrap/Button'
offerStore = require '../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'OfferRow'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    offerStore: @.getFlux().store('offerStore')

  toggleVisited: ->
    @.getFlux().actions.toggleOfferVisit(@props.offer)

  render: ->
    <tr className='offer-row'>
      <td className='name'>{@props.offer.name}</td>
      <td>{@props.offer.categoryName}</td>
      <td><Stars count={@props.offer.rating} /></td>
      <td>{@props.offer.distanceString}</td>
      <td>
        <Button onClick={@.toggleVisited}>
          {if @props.offer.visited then 'Nicht besucht' else 'Schon besucht'}
        </Button>
      </td>
    </tr>
