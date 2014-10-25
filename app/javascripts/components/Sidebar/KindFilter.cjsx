React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
filterStore = require '../../stores/filterStore'
filterActions = require '../../actions/filterActions'
Fluxxor = require 'fluxxor'
FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin
flux = require '../../flux'

module.exports = React.createClass
  mixins: [FluxMixin, StoreWatchMixin("filterStore")]

  getStateFromFlux: ->
    kindFilter: @.getFlux().store("filterStore").getKinds()

  getDefaultProps: ->
    flux: flux

  reset: ->
    store = @.getFlux().store('filterStore')
    # console.log 'KindFilter.reset: Before', store.getKinds()
    store.reset()
    # console.log 'KindFilter.reset: After', store.getKinds()
    @state = @getStateFromFlux()

  updateFilter: (event) ->
    kindFilter = @state.kindFilter
    kindFilter[event.target.name] = !kindFilter[event.target.name]
    @.getFlux().actions.mergeFilter(kinds: kindFilter)
    event.target.blur()

  render: ->
    <div className='kinds'>
      <h5 className='text-center'>Arten</h5>
      <ButtonGroup vertical>
        <Button name='free' active={@state.kindFilter.free} onClick={@.updateFilter}>Kostenlos</Button>
        <Button name='halfPrice' active={@state.kindFilter.halfPrice} onClick={@.updateFilter}>Halber Preis</Button>
        <Button name='special' active={@state.kindFilter.special} onClick={@.updateFilter}>Spezial</Button>
      </ButtonGroup>
    </div>
