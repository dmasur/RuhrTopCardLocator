React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
offerStore = require '../../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'categoryFilter'
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    offerStore = @getFlux().store("offerStore")

    filterFreeOffers: offerStore.getkindFilter().free
    categoryFilter: offerStore.getcategoryFilter()

  getDefaultProps: ->
    flux: require '../../flux'

  reset: ->
    @getFlux().store('offerStore').reset()
    @state = @getStateFromFlux()

  updateFilter: (event) ->
    categoryFilter = @state.categoryFilter
    categoryFilter[event.target.name] = !categoryFilter[event.target.name]
    @getFlux().actions.mergeFilter(categories: categoryFilter)
    event.target.blur()

  render: ->
    <div className='categories'>
      <h5 className='text-center'>Kategorien</h5>
      <ButtonGroup vertical>
        <Button name='action' disabled={@state.filterFreeOffers} active={@state.categoryFilter.action} onClick={@updateFilter}>Erlebnis, Spaß und Action</Button>
        <Button name='water' disabled={@state.filterFreeOffers} active={@state.categoryFilter.water} onClick={@updateFilter}>Schifffahrt und Bäder</Button>
        <Button name='industry' disabled={@state.filterFreeOffers} active={@state.categoryFilter.industry} onClick={@updateFilter}>Erlebnis Industriekultur</Button>
        <Button name='museeum' disabled={@state.filterFreeOffers} active={@state.categoryFilter.museeum} onClick={@updateFilter}>Schätze und Museen</Button>
      </ButtonGroup>
    </div>
