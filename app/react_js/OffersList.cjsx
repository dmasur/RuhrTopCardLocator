React = require 'react'
OfferRow = require './OfferRow'

OffersList = React.createClass
  getDefaultProps: ->
    offers: []
  render: ->
    rows = []
    this.props.offers.forEach (offer) ->
      rows.push <OfferRow offer={offer} />

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

module.exports = OffersList
