React = require 'react'
ListInfo = require './ListInfo'
Sidebar = require './Sidebar'
OffersList = require './OffersList'
Map = require './Map'
offerStore = require '../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    flux = @.getFlux()
    offerStore: flux.store('offerStore')

  getDefaultProps: ->
    offers: []
    flux: require '../flux'

  componentWillMount: ->
    @state.offerStore.setOffers(@props.offers)

  render: ->
    shownOffers = @state.offerStore.getShownOffers()
    <div>
      <div className='sidebar col-md-2'>
        <Sidebar />
      </div>
      <div className='main col-md-10'>
        <ListInfo shownSize={shownOffers.length} allSize={@props.offers.length} />
        <OffersList offers={shownOffers} />
      </div>
    </div>
