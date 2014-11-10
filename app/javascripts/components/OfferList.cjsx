React = require 'react'
OfferRow = require './OfferRow'

module.exports = React.createClass
  displayName: 'OfferList'

  getDefaultProps: ->
    offers: []

  render: ->
    rows = []
    @props.offers.forEach (offer) ->
      rows.push <OfferRow key={offer.id} offer={offer} />

    <table className='table table-striped'>
      <thead>
        <tr>
          <th>Name</th>
          <th>Kategorie</th>
          <th>Bewertung</th>
          <th>Entfernung</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        {rows}
      </tbody>
    </table>
