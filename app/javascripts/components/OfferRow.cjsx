React = require 'react'
Stars = require './Stars'
Button = require 'react-bootstrap/Button'
offerStore = require '../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'OfferRow'

  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    offerStore: @getFlux().store('offerStore')

  toggleVisited: ->
    @getFlux().actions.toggleOfferVisit(@props.offer)

  render: ->
    visitedIcon = if @props.offer.visited
      <i className="fa fa-check-square-o" />
    else
      <i className="fa fa-square-o" />

    <tr className='offer-row'>
      <td className='name'>{@props.offer.name}</td>
      <td>{@props.offer.categoryName}</td>
      <td><Stars count={@props.offer.rating} /></td>
      <td>{@props.offer.distanceString}</td>
      <td>
        <a href='#' onClick={@toggleVisited}>{visitedIcon}</a>
      </td>
    </tr>
