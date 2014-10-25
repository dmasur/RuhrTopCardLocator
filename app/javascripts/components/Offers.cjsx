React = require 'react'
ListInfo = require './ListInfo'
Sidebar = require './Sidebar'
OffersList = require './OffersList'
jQuery = require 'jquery'
filterStore = require '../stores/filterStore'
Fluxxor = require 'fluxxor'
FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin
flux =  require '../flux'

module.exports = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("filterStore")]

  getStateFromFlux: ->
    flux = @.getFlux()
    filterStore: flux.store('filterStore')

  getDefaultProps: ->
    offers: []
    flux: flux

  filterOffers: ->
    @props.offers.filter (offer) =>
      showOffer = !@state.filterStore.getKinds()[offer.kind]
      showOffer

  render: ->
    shownOffers = @.filterOffers()
    <div>
      <div className='sidebar col-md-2'>
        <Sidebar />
      </div>
      <div className='main col-md-10'>
        <ListInfo shownSize={shownOffers.length} allSize={@props.offers.length} />
        <OffersList offers={shownOffers} />
      </div>
    </div>
