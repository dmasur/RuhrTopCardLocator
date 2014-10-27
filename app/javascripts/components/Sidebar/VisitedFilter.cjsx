React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
offerStore = require '../../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'VisitedFilter'
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    visitFilter: @getFlux().store("offerStore").getVisitFilter()

  getDefaultProps: ->
    flux: require '../../flux'

  reset: ->
    store = @getFlux().store('offerStore')
    store.reset()
    @state = @getStateFromFlux()

  updateFilter: (event) ->
    visitFilter = @state.visitFilter
    visitFilter[event.target.name] = !visitFilter[event.target.name]
    @getFlux().actions.mergeFilter(visitFilter: visitFilter)
    event.target.blur()

  render: ->
    <div className='kinds'>
      <h5 className='text-center'>Besuch</h5>
      <ButtonGroup vertical>
        <Button name='visited' active={@state.visitFilter.visited} onClick={@updateFilter}>Schon Besucht</Button>
        <Button name='unvisited' active={@state.visitFilter.unvisited} onClick={@updateFilter}>Unbesucht</Button>
      </ButtonGroup>
    </div>
