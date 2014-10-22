React = require 'react'
ListInfo = require './ListInfo'
Sidebar = require './Sidebar'
OffersList = require './OffersList'
jQuery = require 'jquery'

module.exports = React.createClass
  getInitialState: ->
    filters:
      free: false
      halfPrice: false
      special: false
    shownOffers: @props.offers

  getDefaultProps: ->
    offers: []

  filterOffers: ->
    @props.offers.filter (offer) =>
      showOffer = !@state.filters[offer.kind]
      showOffer

  updateFilter: (filters) ->
    this.state.filters = jQuery.merge(@state.filters, filters)

    this.setState
      filters: @state.filters
      shownOffers: @.filterOffers()

  render: ->
    <div>
      <div className='sidebar col-lg-2'>
        <Sidebar updateFilter={this.updateFilter} filters={this.state.filters}/>
      </div>
      <div className='main col-lg-10'>
        <ListInfo shownSize={this.state.shownOffers.length} allSize={this.props.offers.length} />
        <OffersList offers={this.state.shownOffers} />
      </div>
    </div>
