React = require 'react'
ListInfo = require './ListInfo'
Sidebar = require './Sidebar'
OffersList = require './OffersList'
jQuery = require 'jquery'
filterStore = require './stores/filter/store'
ReactFlux = require 'react-flux'

module.exports = React.createClass
  mixins: [ ReactFlux.mixin(filterStore) ]

  getStateFromStores: ->
    filters: filterStore.state

  getDefaultProps: ->
    offers: []

  filterOffers: ->
    @props.offers.filter (offer) =>
      showOffer = !@state.filters.get offer.kind
      showOffer

  render: ->
    shownOffers = @.filterOffers()
    <div>
      <div className='sidebar col-lg-2'>
        <Sidebar />
      </div>
      <div className='main col-lg-10'>
        <ListInfo shownSize={shownOffers.length} allSize={this.props.offers.length} />
        <OffersList offers={shownOffers} />
      </div>
    </div>
